module app.auth.AdminBasicAuthRealm;

// import app.auth.AdminJwtToken;
import app.auth.Constants;
import app.data.DicothAdminUserService;

import hunt.framework.auth;
import hunt.shiro;

import hunt.logging.ConsoleLogger;


/** 
 * 
 */
class AdminBasicAuthRealm : BasicAuthRealm {
    private DicothAdminUserService _userService;

    this() {
        _userService = new DicothAdminUserService();
    }
    
    override bool supports(AuthenticationToken token) {
        version(HUNT_AUTH_DEBUG) info(typeid(cast(Object)token));
        
        UsernamePasswordToken t = cast(UsernamePasswordToken)token;
        if(t is null)
            return false;
        tracef("name: %s", t.name());
        return t.name() ==  ADMIN_BASIC_TOKEN_NAME;
    }

    override protected UserService getUserService() {
        return _userService;
    }
}
