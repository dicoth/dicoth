module app.component.system.repository.RolePermissionRepository;

import app.component.system.model.Permission;
import app.component.system.model.RolePermission;
import app.component.system.repository.PermissionRepository;

import hunt.entity;
import hunt.entity.repository;
import hunt.framework.Simplify;

class RolePermissionRepository : EntityRepository!(RolePermission, int) {

    this() {
        super(defaultEntityManager());
    }

    Permission[] getRolePermissions(int roleId) {
        RolePermission[] rolePermissions = _manager.createQuery!(RolePermission)(" SELECT rp FROM RolePermission rp WHERE rp.role_id = :roleId ")
            .setParameter("roleId", roleId)
            .getResultList();
        Permission[] permissions;
        auto permissionRepository = new PermissionRepository();
        foreach (rolePermission; rolePermissions) {
            permissions ~= permissionRepository.findById(rolePermission.permission_id);
        }
        return permissions;
    }

    int[] getRolePermissionIds(int roleId) {
        RolePermission[] rolePermissions = _manager.createQuery!(RolePermission)(" SELECT rp FROM RolePermission rp WHERE rp.role_id = :roleId ")
            .setParameter("roleId", roleId)
            .getResultList();
        int[] ids;
        foreach (rolePermission; rolePermissions) {
            ids ~= rolePermission.permission_id;
        }
        return ids;
    }

    bool saves(int roleId, int[] permissionIds) {
        RolePermission[] rolePermission;
        foreach(permissionId; permissionIds){
            RolePermission r = new RolePermission();
            r.role_id = roleId;
            r.permission_id = permissionId;
            rolePermission ~= r;
        }
        this.saveAll(rolePermission);
        return true;
    }

    bool removes(int roleId) {
        RolePermission[] rolePermissions = _manager.createQuery!(RolePermission)(" SELECT rp FROM RolePermission rp WHERE rp.role_id = :roleId ")
            .setParameter("roleId", roleId)
            .getResultList();
        this.removeAll(rolePermissions);
        return true;
    }

}
