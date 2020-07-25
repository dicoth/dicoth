module app.auth.UserBasicAuthRealm;

// import app.auth.AdminJwtToken;
import app.auth.Constants;
import app.data.DicothUserService;

import hunt.framework.auth;
import hunt.shiro;

import hunt.logging.ConsoleLogger;


/** 
 * 
 */
class UserBasicAuthRealm : BasicAuthRealm {
    private DicothUserService _userService;

    this() {
        _userService = new DicothUserService();
    }
    
    override bool supports(AuthenticationToken token) {
        // warning(typeid(cast(Object)token));
        
        UsernamePasswordToken t = cast(UsernamePasswordToken)token;
        if(t is null)
            return false;
        bool r = t.name() ==  USER_BASIC_TOKEN_NAME; 
        tracef("name: %s, result: %s", t.name(), r);
        return r;
    }

    override protected UserService getUserService() {
        return _userService;
    }
}
