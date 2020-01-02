module app.component.attachment.repository.AttachmentRepository;

import hunt.entity;

import app.component.user.model.User;
import app.component.attachment.model.Attachment;
import hunt.logging;
import hunt.framework.file.UploadedFile;
import std.digest.md;
import hunt.util.DateTime;
import app.component.forum.model.Post;
import std.algorithm.searching;

import std.array;
import std.conv;

class AttachmentRepository : EntityRepository!(Attachment, int)
{
    this(EntityManager manager) {
        super(manager);
    }

    Attachment[] findAllByPost(Post[] posts)
    {


        string[] strArr;
        foreach(post; posts)
        {
            if(!canFind(strArr, post.id.to!string))
            {
                strArr ~= post.id.to!string;
            }
        }
        if(strArr.length == 0)
        {
            return null;
        }
        auto query = _manager.createQuery!(Attachment)("SELECT * FROM Attachment u WHERE u.type = 'post' and u.item_id in ("~strArr.join(",")~") and is_used=0 and deleted = 0;");
        return query.getResultList();
    }

    int updatePostAttachments(int uid, int postId)
    {
        auto query = _manager.createQuery!(Attachment)("UPDATE Attachment u SET u.item_id=:postId WHERE u.uid=:uid AND u.item_id=0 AND u.type='post'");
        query.setParameter("uid", uid);
        query.setParameter("postId", postId);
        return query.exec();
    }

    int updatePostAttachmentsBulk(string postid,string uid, string attachment_ids)
    {        
        auto results = _manager.getDatabase().query(
            "UPDATE hc_attachment u SET item_id="~  postid ~ "  WHERE u.id in ("~attachment_ids~") and  u.uid="~uid~" AND u.item_id=0 AND u.type='post'"
            );
        return 1;
    }

    bool updatePostAttachmentsUsed(int[] usedAttachments)
    {
        string[] arr;
        foreach(val; usedAttachments)
        {
            arr ~= val.to!string;
        }
        if(arr.length == 0)
        {
            return false;
        }
        auto query = _manager.createQuery!(Attachment)("UPDATE Attachment u SET u.is_used=1 WHERE u.id in ("~arr.join(",")~")  ");
        query.exec();
        return true;
    }

    Attachment findUserUploadFile(int uid, string filename)
    {
        auto query = _manager.createQuery!(Attachment)("SELECT * FROM Attachment u WHERE u.type = 'post' and u.filename=:filename and u.uid=:uid and item_id=0;");
        query.setParameter("filename", filename);
        query.setParameter("uid", uid);
        return query.getSingleResult();
    }

    Page!Attachment findPageByAttachment(int uid, int page = 0, int limit = 10)
    {
        page = page < 1 ? 0 : page;
        limit = limit < 1 ? 10 : limit;

        string sql = " SELECT a,u FROM Attachment a  LEFT JOIN User u ON u.id = a.uid ";
        string[] wheres = [" a.deleted  = 0 "];

        if(uid != 0)
        {
            wheres ~= " a.uid = :uid ";
        }

        if(wheres.length > 0)
        {
            sql ~= "WHERE";

            for(int i = 0; i < wheres.length; i++)
            {
                if(i > 0)
                {
                    sql ~= "AND";
                }

                sql ~= wheres[i];
            }
        }

        sql ~= " ORDER BY a.created ASC";
        auto query = _manager.createQuery!(Attachment)(sql, new Pageable(page, limit));
        query.setParameter("uid", uid);

        return query.getPageResult;
    }


    bool DelByPost(int deleted, int time)
    {
        auto temp1 = _manager.createQuery!(Attachment)(" UPDATE Attachment a set a.deleted = :now WHERE a.id = :deleted ")
        .setParameter("now", time)
        .setParameter("deleted", deleted)
        .exec();
        return true;
    
    }

     Attachment findAttachmentById(int id){
        string sql = " SELECT a,u FROM Attachment a LEFT JOIN User u ON u.id = a.uid WHERE a.id = :id LIMIT 1";
        return _manager.createQuery!(Attachment)(sql).setParameter("id", id).getSingleResult();
    }

    Attachment findAttachmentByUidAndId(int uid, int id)
    {
        auto query = _manager.createQuery!(Attachment)("SELECT * FROM Attachment u WHERE u.uid = :uid AND u.id = :id LIMIT 1;");
        query.setParameter("uid", uid);
        query.setParameter("id", id);
        return query.getSingleResult();
    }

    Attachment[] findAllByItemId(int item_id)
    {    
        auto query = _manager.createQuery!(Attachment)("SELECT * FROM Attachment u WHERE u.type = 'post' AND u.item_id = :item_id AND is_used=0 and deleted = 0;");
        query.setParameter("item_id", item_id);
        return query.getResultList();
    }

    bool saveAttachmentData(Attachment attachment){
        auto temp1 = _manager.createQuery!(Attachment)(" UPDATE Attachment a set a.deleted = :deleted, a.status = :status, a.audited = :audited WHERE a.id = :id ")
            .setParameter("status", attachment.status)
            .setParameter("deleted", attachment.deleted)
            .setParameter("audited", attachment.audited)
            .setParameter("id", attachment.id)
            .exec();
        return true;
    }


    bool savePostData(Post post){
        auto temp1 = _manager.createQuery!(Post)(" UPDATE Post p set p.deleted = :deleted, p.status = :status, p.audited = :audited WHERE p.id = :id ")
            .setParameter("status", post.status)
            .setParameter("deleted", post.deleted)
            .setParameter("audited", post.audited)
            .setParameter("id", post.id)
            .exec();
        return true;
    }

    Attachment findPostAttachmentByUid(int uid)
    {
        auto query = _manager.createQuery!(Attachment)("SELECT * FROM Attachment u WHERE u.uid=:uid AND u.item_id=0 AND u.type='post';");
        query.setParameter("uid", uid);
        return query.getSingleResult();
    }

    int findCountAttachmentByUid(int uid, int item_id)
    {
        int count;
        auto results = _manager.getDatabase().query("SELECT count(*) as count1 FROM "~Field._tableName~" WHERE uid='"~uid.to!string~"' AND item_id='"~item_id.to!string~"' AND type='post' AND deleted > 0 ;");
        foreach(Row result; results)
        {
            count = result.getValue("count1").toString.to!int;
        }
        
        return count;
    }
}
