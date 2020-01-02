module app.component.forum.repository.PostRepository;

import hunt.logging;
import hunt.entity;

import app.component.forum.model.Post;

import std.conv;

class PostRepository : EntityRepository!(Post, int)
{
    this(EntityManager manager) {
        super(manager);
        this.setCharset();
    }
    // 
    void setCharset(){
        _manager.getDatabase().query("SET NAMES utf8mb4");
    }
    Post[] findNewestByForum(short limit)
    {
        auto query = _manager.createQuery!(Post)("SELECT p FROM Post p WHERE p.status = 1 and p.deleted=0 order by p.posts desc limit "~limit.to!string~";");
        return query.getResultList();
    }

    Post[] findNewestByUid(int uid, short limit)
    {
        auto query = _manager.createQuery!(Post)("SELECT p FROM Post p WHERE p.uid = :uid and p.status = 1 and p.deleted=0 order by p.created desc limit "~limit.to!string~";");
        query.setParameter("uid", uid);
        return query.getResultList();
    }

    Page!Post findAllByThreadId(int threadId, int page, int limit)
    {
        return _manager.createQuery!(Post)("SELECT p,u FROM Post p LEFT JOIN User u ON u.id = p.uid WHERE p.thread_id=:threadId and p.status = 1 and p.deleted=0", new Pageable(page - 1, limit))
        .setParameter("threadId", threadId)
        .getPageResult();
    }

    int findCountByUid(int uid)
    {
        int count;
        auto results = _manager.getDatabase().query("SELECT count(*) as count1 FROM "~Field._tableName~" WHERE uid='"~uid.to!string~"'");
        foreach(Row result; results)
        {
            count = result.getValue("count1").toString.to!int;
        }
        
        return count;
    }


    Page!Post findPageByPost(int threadId, int uid, int page = 0, int limit = 10, string title = "", string nickname = "")
    {
        limit = limit < 1 ? 10 : limit;
        page = page < 1 ? 0 : page;

        string sql = " SELECT p,t,u FROM Post p LEFT JOIN Thread t ON t.id = p.thread_id LEFT JOIN User u ON u.id = p.uid ";
        string[] wheres = [" p.deleted = 0 "];
        if(threadId)
        {
            wheres ~= " p.thread_id = :threadId ";
        }

        if(uid)
        {
            wheres ~= " p.uid = :uid ";
        }

        if(title)
        {
            wheres ~= " t.title like '%"~title~"%' ";
        }

        if(nickname)
        {
            wheres ~= " u.nickname = :nickname ";
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

        sql ~= " ORDER BY p.created ASC";
        auto query = _manager.createQuery!(Post)(sql, new Pageable(page, limit));
        query.setParameter("threadId", threadId);
        query.setParameter("uid", uid);
        query.setParameter("title", title);
        query.setParameter("nickname", nickname);

        return query.getPageResult;
    }

    bool DelByPost(int deleted, int time)
    {
        auto temp1 = _manager.createQuery!(Post)(" UPDATE Post p set p.deleted = :now WHERE p.id = :deleted ")
        .setParameter("now", time)
        .setParameter("deleted", deleted)
        .exec();
        
        return true;
    
    }

    Post findPostById(int id){
        string sql = " SELECT p,t,u FROM Post p LEFT JOIN Thread t ON t.id = p.thread_id LEFT JOIN User u ON u.id = p.uid WHERE p.id = :id LIMIT 1";
        return _manager.createQuery!(Post)(sql).setParameter("id", id).getSingleResult();
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
}