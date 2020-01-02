module app.component.system.repository.PermissionRepository;

import app.component.system.model.Permission;
import app.component.system.model.PermissionGroup;

import hunt.entity.EntityManager;
import hunt.entity.repository;
import hunt.framework.Simplify;

class PermissionRepository : EntityRepository!(Permission, int) {

    this() {
        super(defaultEntityManager());
    }

    Page!Permission findByPermission(string keyWord = "", int status = -1, int page = 0, int perPage = 10) {
        
        page = page < 1 ? 0 : page;
        perPage = perPage < 1 ? 10 : perPage;
        string sql = " SELECT p FROM Permission p  ";
       
        string[] wheres;

        if(keyWord)
        {
            wheres ~= " p.title = :keyWord ";
        }

        if(status != -1)
        {
            wheres ~= " p.status = :status";

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

        sql ~= " ORDER BY p.id ASC";
        auto query = _manager.createQuery!(Permission)(sql, new Pageable(page, perPage));
             query.setParameter("keyWord", keyWord);
             query.setParameter("status", status);
        return query.getPageResult;    
        
    }

    Page!PermissionGroup findByPermissionGroup(int page = 1, int perPage = 10) {
        page = page < 1 ? 1 : page;
        perPage = perPage < 1 ? 10 : perPage;
        string sql = "SELECT p FROM PermissionGroup p";
        auto temp1 = _manager.createQuery!(PermissionGroup)(sql, new Pageable(page - 1, perPage))
            .getPageResult();
        return temp1;
    }

}
