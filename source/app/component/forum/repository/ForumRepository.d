module app.component.forum.repository.ForumRepository;

import hunt.entity;
import hunt.database.base.Row;

import app.component.forum.model.Forum;
import app.component.forum.model.Thread;
import hunt.logging;
import std.string;
import std.conv;



class ForumRepository : EntityRepository!(Forum, int)
{
    this(EntityManager manager) {
        super(manager);
    }


    Forum[][int] getGroupForums()
    {
        Forum[][int] groupForums;
        foreach (forum; this.findAll())
        {
            groupForums[forum.pid] ~= forum;
        }

        return groupForums;
    }



    Page!Forum findByForum(string keyWord = "", int page = 0, int perPage = 10)
    {
        
        page = page < 1 ? 0 : page;
        perPage = perPage < 1 ? 10 : perPage;
        string sql = " SELECT c FROM Forum c ";
        string[] wheres = [" c.deleted = 0 AND c.pid = 0 "];


        if(keyWord)
        {
            wheres ~= " c.name like '%"~keyWord~"%' ";
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

        sql ~= " ORDER BY c.id ASC";
        auto query = _manager.createQuery!(Forum)(sql, new Pageable(page, perPage));
             query.setParameter("keyWord", keyWord);
        
        return query.getPageResult;
        
    }

    Page!Forum findAllByForum(int pid, int page = 0, int perPage = 10)
    {
        page = page < 1 ? 0 : page;
        perPage = perPage < 1 ? 10 : perPage;

        auto tem = _manager.createQuery!(Forum)("SELECT c FROM Forum c WHERE c.deleted = 0 AND c.pid = :pid ORDER BY c.created ASC", new Pageable(page, perPage))
            .setParameter("pid", pid)
            .getPageResult();
        return tem;
    }


    bool DelByForum(int deleted, int time)
    {
        auto temp1 = _manager.createQuery!(Forum)("Update Forum c SET c.deleted = :now WHERE c.id= :deleted")
            .setParameter("now", time)
            .setParameter("deleted", deleted)
            .exec();
        return true;
    }


    int DelForum(int pid)
    {
        int res;
        auto findCount = _manager.getDatabase().query("SELECT COUNT(id) AS num FROM hc_forum WHERE deleted = 0 AND pid = " ~ pid.to!string);
        foreach(tmpData; findCount)
        {
            string v = tmpData["num"].toString();
            res = v != "" && isNumeric(v) ? v.to!int : 0; 
            break;
        }
        return res;
    }








    Forum findUsableById(int id)
    {
        auto query = _manager.createQuery!(Forum)("SELECT * FROM Forum u WHERE u.id = :id and u.deleted=0");
        query.setParameter("id", id);
        return query.getSingleResult();
    }

    Forum[] findAllByUsable()
    {
        auto query = _manager.createQuery!(Forum)("SELECT * FROM Forum u WHERE u.status = 1 and u.deleted=0 order by updated desc;");
        return query.getResultList();
    }

    Forum[] findAllByUsable(Thread[] threads)
    {
        string[] ids;
        foreach(thread; threads)
        {
            ids ~= thread.forum_id.to!string;
        }
        if(ids.length == 0)
        {
            return null;
        }
        auto query = _manager.createQuery!(Forum)("SELECT * FROM Forum u WHERE u.id in("~ids.join(",")~") and u.status = 1 and u.deleted=0 order by updated desc;");
        return query.getResultList();
    }






}
