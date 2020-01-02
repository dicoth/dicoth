module app.component.forum.repository.ThreadRepository;

import hunt.entity;

import app.component.forum.model.Thread;
import app.component.forum.model.Forum;
import app.component.forum.model.Post;
import app.component.forum.repository.ForumRepository;
import hunt.entity.domain.Page;
import hunt.logging;

import std.array;
import std.conv;

class ThreadRepository : EntityRepository!(Thread, int)
{
    this(EntityManager manager) {
        super(manager);
    }

    Thread findUsableById(int id)
    {
        auto query = _manager.createQuery!(Thread)("SELECT t,f FROM Thread t LEFT JOIN Forum f ON f.id=t.forum_id  WHERE t.id = :id and t.status = 1 and t.deleted=0;");
        query.setParameter("id", id);
        return query.getSingleResult();
    }

    Thread[] hot(short limit)
    {
        auto query = _manager.createQuery!(Thread)("SELECT t,u FROM Thread t LEFT JOIN User u ON u.id=t.uid WHERE t.status = 1 and t.deleted=0 order by t.posts desc limit "~limit.to!string~";");
        return query.getResultList();
    }

    Thread[] findNewestByForum(Forum[] forums)
    {
        Thread[] threads;
        if(forums.length == 0)
        {
            return threads;
        }

        foreach(forum; forums)
        {
            auto query = _manager.createQuery!(Thread)("SELECT t,u FROM Thread t LEFT JOIN User u ON u.id=t.last_uid WHERE t.forum_id="~forum.id.to!string~" and t.status = 1 and t.deleted=0 order by t.last_time desc;");
            auto result = query.getSingleResult();         
            if(result)
            {
                threads ~= result;
            }
        }
        return threads;
    }

    Page!Thread findAllByForumId(int forumId, int page, int limit )
    {
        if(forumId > 0)
        {
            return _manager.createQuery!(Thread)("SELECT t,u FROM Thread t LEFT JOIN User u ON u.id=t.uid WHERE t.forum_id=:forumId and t.status = 1 and t.deleted=0 order by t.last_time desc", new Pageable(page - 1, limit))
            .setParameter("forumId", forumId)
            .getPageResult();
        }else{
            return _manager.createQuery!(Thread)("SELECT t,u FROM Thread t LEFT JOIN User u ON u.id=t.last_uid WHERE t.status = 1 and t.deleted=0 order by t.last_time desc", new Pageable(page - 1, limit))
            .getPageResult();
        }
    }

    Page!Thread findAllByUid(int uid, int page, int limit )
    {
        return _manager.createQuery!(Thread)("SELECT * FROM Thread t WHERE t.uid=:uid and t.status = 1 and t.deleted=0 order by t.last_time desc", new Pageable(page - 1, limit))
        .setParameter("uid", uid)
        .getPageResult();
    }

    Thread[] findHotByUid(int uid, short limit)
    {
        auto query = _manager.createQuery!(Thread)("SELECT * FROM Thread t WHERE t.uid = :uid and t.status = 1 and t.deleted=0 order by t.posts desc limit "~limit.to!string~";");
        query.setParameter("uid", uid);
        return query.getResultList();
    }

    Thread[] findAllByPost(Post[] posts)
    {
        string[] ids;
        foreach(post; posts)
        {
            ids ~= post.thread.id.to!string;
        }
        if(ids.length == 0)
        {
            return null;
        }
        auto query = _manager.createQuery!(Thread)("SELECT * FROM Thread t WHERE t.id in ("~ids.join(",")~") and t.status = 1 and t.deleted=0 order by t.created desc;");
        return query.getResultList();
    }

    void read(Thread thread)
    {
        ///TODO LIST
        thread.views += 1;
        this.update(thread);
    }
    Page!Thread selectListByWords(string title,int page,int limit)
    {
        return _manager.createQuery!(Thread)("SELECT * FROM Thread t LEFT JOIN User u ON t.uid = u.id WHERE t.title like '%"~title~"%'",new Pageable(page - 1, limit))
        .setParameter("title", title)
        .getPageResult();
    }
}
