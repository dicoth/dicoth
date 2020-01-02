module app.component.user.repository.UserOauthRepository;

import hunt.entity;
import hunt.framework.Simplify;
import app.component.user.model.UserOauth;

class UserOauthRepository : EntityRepository!(UserOauth, int)
{
    this(EntityManager manager = null) {
        super(defaultEntityManager());
    }

    UserOauth findByOauthToken(string oauth_token ){
        auto query = _manager.createQuery!(UserOauth)("SELECT * FROM UserOauth u WHERE u.oauth_token = :oauth_token limit 1");
        query.setParameter("oauth_token", oauth_token);
        return query.getSingleResult();
    }

    UserOauth findByUid( string uid ){
        auto query = _manager.createQuery!(UserOauth)("SELECT * FROM UserOauth u WHERE u.uid = :uid limit 1");
        query.setParameter("uid", uid);
        return query.getSingleResult();
    }   
    
}
