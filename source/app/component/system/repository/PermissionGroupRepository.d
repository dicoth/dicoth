module app.component.system.repository.PermissionGroupRepository;

import app.component.system.model.PermissionGroup;

import hunt.entity;
import hunt.entity.EntityManager;
import hunt.entity.repository;
import hunt.framework;
import hunt.logging;

class PermissionGroupRepository : EntityRepository!(PermissionGroup, int) {

    this() {
        super(defaultEntityManager());
    }

    Page!PermissionGroup findByPermissionGroup(int page = 1, int perPage = 10) {
        page = page < 1 ? 1 : page;
        perPage = perPage < 1 ? 10 : perPage;
        string sql = "SELECT p FROM PermissionGroup p";
        auto temp = _manager.createQuery!(PermissionGroup)(sql, new Pageable(page - 1, perPage))
        .getPageResult();
        return temp;
    }

}
