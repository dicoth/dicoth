module app.component.user.repository.UserVerifycodeRepository;

import hunt.entity;
import hunt.framework.Simplify;
import app.component.user.model.UserVerifycode;

class UserVerifycodeRepository : EntityRepository!(UserVerifycode, int)
{
    this(EntityManager manager = null) {
        super(defaultEntityManager());
    }

    UserVerifycode findByAccountCodeRecenty(string account ){
        import std.conv;
        string time =  (time()-60).to!string;
        auto query = _manager.createQuery!(UserVerifycode)("SELECT * FROM UserVerifycode u WHERE u.account = :account and created > :time");
        query.setParameter("account", account);
        query.setParameter("time", time);
        return query.getSingleResult();
    }

    UserVerifycode findByAccountCode(string account ,string code ){
        auto query = _manager.createQuery!(UserVerifycode)("SELECT * FROM UserVerifycode u WHERE u.account = :account and code = :code");
        query.setParameter("account", account);
        query.setParameter("code", code);
        return query.getSingleResult();
    }

    auto updateStatus(string account){
        import std.conv;
        string now =  time().to!string;
        auto temp1 = _manager.createQuery!(UserVerifycode)(" UPDATE UserVerifycode p set p.status = 0,updated=:now WHERE p.account = :account ")
        .setParameter("now", now)
        .setParameter("account", account)
        .exec();
        
        return true;
    }

   
    
}
