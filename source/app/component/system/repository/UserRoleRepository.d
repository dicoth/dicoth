module app.component.system.repository.UserRoleRepository;

import app.component.system.model.Role;
import app.component.system.model.User;
import app.component.system.model.UserRole;

import hunt.entity;
import hunt.entity.EntityManager;
import hunt.entity.repository;
import hunt.framework;

import std.algorithm;

class UserRoleRepository : EntityRepository!(UserRole, int) {

    this() {
        super(defaultEntityManager());
    }

    int[] getUserRoleIds(int userId) {
        string sql = "SELECT ur FROM UserRole ur WHERE ur.user_id = :userId";
        auto userRoles = _manager.createQuery!(UserRole)(sql)
            .setParameter("userId", userId)
            .getResultList();
        int[] ids;
        foreach (userRole; userRoles) {
            ids ~= userRole.role_id;
        }
        return ids;
    }


    bool saves(int userId, int[] roleIds) {
        UserRole[] userRole;
        foreach(roleId; roleIds){
            UserRole r = new UserRole();
            r.user_id = userId;
            r.role_id = roleId;
            userRole ~= r;
        }
        this.saveAll(userRole);
        return true;
    }

    bool removes(int userId) {
        string sql = "SELECT ur FROM UserRole ur WHERE ur.user_id = :userId ";
        auto userRoles = _manager.createQuery!(UserRole)(sql)
            .setParameter("userId", userId)
            .getResultList();
        if (userRoles !is null)
            this.removeAll(userRoles);
        return true;
    }

}
