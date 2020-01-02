module app.component.system.authentication.AdminCmsRealm;


import app.lib.Exceptions;
import app.component.system.authentication.JwtToken;
import app.component.system.authentication.JwtUtil;


import app.component.system.helper.Password;
import app.component.system.model.User;
import app.component.system.model.Permission;
import app.component.system.model.Menu;
import app.component.system.model.Role;
import app.component.system.model.UserRole;

import app.component.system.repository.PermissionRepository;
import app.component.system.repository.RoleRepository;
import app.component.system.repository.RolePermissionRepository;
import app.component.system.repository.UserRepository;
import app.component.system.repository.UserRoleRepository;

import hunt.shiro;

import hunt.collection;
import hunt.entity;
import hunt.entity.DefaultEntityManagerFactory;
import hunt.logging.ConsoleLogger;
import hunt.String;
import hunt.framework.Simplify;

alias PermissionModel = app.component.system.model.Permission.Permission;


class AdminCmsRealm : AuthorizingRealm {

    EntityManager _cManager;

    this() {
        super();
        setCredentialsMatcher(new AllowAllCredentialsMatcher());
    }

    ~this() {
        closeDefaultEntityManager();
        // if(_cManager !is null) {
        //     _cManager.close();
        // }
    }

    
    override
    bool supports(AuthenticationToken token) {
        JwtToken jt = cast(JwtToken)token;
        return jt !is null;
    }

    void initEntityManager() {
        if(_cManager is null) {
            _cManager = defaultEntityManagerFactory().createEntityManager();
        }
    }

    
    override protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken token) {
        initEntityManager();
        string tokenString = token.getPrincipal();
        string username = JwtUtil.getUsername(tokenString);
        version(HUNT_DEBUG) {
            trace(tokenString);
            infof("principal: %s", username);
        }

        auto userModel = (new UserRepository()).findByEmail(username);



        if(userModel !is null) {
            if(JwtUtil.verify(tokenString, username, userModel.password)) {
                String credentials = new String(tokenString);
                SimpleAuthenticationInfo info = new SimpleAuthenticationInfo(userModel, credentials, getName());
                return info;
            } else {
                warning("Wrong password!");
                throw new WrongPasswordException(username);
            }
        }

        warning("Your email has not been found or has been banned");
        throw new WrongEmailException(username);
    }

    override protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principals) {
        initEntityManager();
        
        User user = cast(User) principals.getPrimaryPrincipal();
        if(user is null) {
            warning("no principals");
            return null;
        }
        version(HUNT_DEBUG) infof("principals: %s", user.name);

        SimpleAuthorizationInfo info = new SimpleAuthorizationInfo();

        RoleRepository roleRep = new RoleRepository();
        Role[] userRoles = roleRep.getUserRoles(user.id);

        RolePermissionRepository rpRep = new RolePermissionRepository();
        foreach(Role r; userRoles) {

            // roles
            info.addRole(r.name);
            version(HUNT_DEBUG) tracef("Role: id=%d, name=%s", r.id,  r.name);

            // permissions
            if(r.name == "admin" || r.name == "administrator" || r.name == "Super administrator" )  {
                info.addStringPermission("*"); // for administrator
            } else {
                foreach(PermissionModel p; rpRep.getRolePermissions(r.id)) {
                    // tracef("Permission: id=%d, uid=%s, title=%s", p.id, p.mca, p.title);
                    info.addStringPermission(p.mca);
                }
            }
        }

        return info;
    }

}