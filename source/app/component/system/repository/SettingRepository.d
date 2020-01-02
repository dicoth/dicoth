module app.component.system.repository.SettingRepository;

import app.component.system.model.Setting;

import hunt.entity;
import hunt.framework.Simplify;

class SettingRepository : EntityRepository!(Setting, string) {

    this() {
        super(defaultEntityManager());
    }

    Setting findById(int id) { 
        return _manager.createQuery!(Setting)("SELECT s FROM Setting s WHERE s.id = :id ")
            .setParameter("id", id)
            .getSingleResult();
    }

    Page!Setting getList(int page = 1, int perPage = 10) { 
        page = page < 1 ? 1 : page;
        perPage = perPage < 1 ? 10 : perPage;
        return _manager.createQuery!(Setting)("SELECT s FROM Setting s WHERE s.deleted = 0",new Pageable(page - 1, perPage))
            .getPageResult();
    }

    Setting findByKey(string key) { 
        return _manager.createQuery!(Setting)("SELECT s FROM Setting s WHERE s.key = :key and s.deleted = 0 ")
            .setParameter("key", key)
            .getSingleResult();
    }
    
}
