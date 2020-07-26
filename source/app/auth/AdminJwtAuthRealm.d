module app.auth.AdminJwtAuthRealm;

// import app.auth.AdminJwtToken;
import app.auth.Constants;
import app.data.DicothAdminUserService;

import hunt.framework.auth;
import hunt.shiro;

import hunt.logging.ConsoleLogger;


/** 
 * 
 */
class AdminJwtAuthRealm : JwtAuthRealm {
    private DicothAdminUserService _userService;

    this() {
        _userService = new DicothAdminUserService();
    }
    
    override bool supports(AuthenticationToken token) {
        version(HUNT_AUTH_DEBUG) info(typeid(cast(Object)token));

        JwtToken t = cast(JwtToken)token;
        if(t is null)
            return false;
        tracef("name: %s", t.name());
        return t.name() == ADMIN_JWT_TOKEN_NAME;        
    }

    override protected UserService getUserService() {
        return _userService;
    }
}
