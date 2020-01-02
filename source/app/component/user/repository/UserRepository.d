module app.component.user.repository.UserRepository;

import hunt.entity;
import hunt.framework.Simplify;
import app.component.user.model.User;

class UserRepository : EntityRepository!(User, int)
{
    this(EntityManager manager = null) {
        super(defaultEntityManager());
    }

    User findUserByUsername(string username)
    {
        auto query = _manager.createQuery!(User)("SELECT u FROM User u WHERE u.username = '"~username~"' OR u.email = '"~username~"';");
        return query.getSingleResult();
    }

    User findUserByNickname(string nickname)
    {
        auto query = _manager.createQuery!(User)("SELECT u FROM User u WHERE u.nickname = :nickname;");
            query.setParameter("nickname", nickname);

        return query.getSingleResult();
    }

    User findUserByEmail(string mail)
    {
        auto query = _manager.createQuery!(User)("SELECT u FROM User u WHERE u.email = :mail ;");
        query.setParameter("mail", mail);
        return query.getSingleResult();
    }

    User findUserInfo(int id)
    {
        auto query = _manager.createQuery!(User)("SELECT u.id,u.email,u.nickname,u.avatar,u.gender,u.created FROM User u WHERE u.id = :id and u.status = 1 ;");
        query.setParameter("id", id);
        return query.getSingleResult();
    }

    User findUserByUnid(string unid)
    {
        auto query = _manager.createQuery!(User)("SELECT u FROM User u WHERE u.unid = :unid ;");
        query.setParameter("unid", unid);
        return query.getSingleResult();
    }

    User findUserByOpenid(string openid)
    {
        auto query = _manager.createQuery!(User)("SELECT u FROM User u WHERE u.openid = :openid ;");
        query.setParameter("openid", openid);
        return query.getSingleResult();
    }

    Page!User findPageByUser(string keyWord = "", int page = 0, int perPage = 10)
    {
        page = page < 1 ? 0 : page;
        perPage = perPage < 1 ? 10 : perPage;
        string sql = " SELECT u FROM User u  ";
       
        string[] wheres;

        if(keyWord)
        {
            wheres ~= " u.nickname = :keyWord OR u.email = :keyWord ";
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

        sql ~= " ORDER BY u.id ASC";
        auto query = _manager.createQuery!(User)(sql, new Pageable(page, perPage));
             query.setParameter("keyWord", keyWord);


        return query.getPageResult;
    }

    string createPassword(string password, string salt)
    {
        import hunt.logging;
        import std.digest;
        import std.digest.hmac;
        import std.digest.sha;
        import std.string : representation;
        import std.uni;

        auto hmac = HMAC!SHA1(salt.representation);
        auto digest = hmac.put(password.representation).finish();
        string f = cast(string)digest.toHexString().dup();
        return f;
    }
    
}
