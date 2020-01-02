module app.component.system.repository.RoleRepository;

import hunt.entity;
import hunt.entity.repository;

import app.component.system.model.Role;
import app.component.system.repository.UserRoleRepository;

import std.conv;
import std.string;
import hunt.framework.Simplify;

class RoleRepository : EntityRepository!(Role, int) {

    this() {
        super(defaultEntityManager());
    }
    
    Role[] getUserRoles(int userId) {
        return this.findAllById(new UserRoleRepository().getUserRoleIds(userId));
    }

    int[] searchPostRoleIds(string[string] requestParams) {
        int[] roleIds;
        foreach(key, value; requestParams) {
            if(indexOf(key, "roleid") != -1) {
                roleIds ~= value.to!int();
            }
        }
        return roleIds;
    }

    Page!Role findByRole(int page = 0, int perPage = 10) {
        page = page < 1 ? 1 : page;
        perPage = perPage < 1 ? 10 : perPage;
        return _manager.createQuery!(Role)("SELECT r FROM Role r", new Pageable(page - 1, perPage))
            .getPageResult();
    }

}
