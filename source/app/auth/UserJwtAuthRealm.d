module app.auth.UserJwtAuthRealm;

// import app.auth.UserJwtToken;
import app.auth.Constants;
import app.data.DicothUserService;

import hunt.framework.auth;
import hunt.shiro;

import hunt.logging.ConsoleLogger;


/** 
 * 
 */
class UserJwtAuthRealm : JwtAuthRealm {
    private DicothUserService _userService;

    this() {
        _userService = new DicothUserService();
        this.setName = typeof(this).stringof;
        this.guardName = USER_GUARD_NAME;
    }
    
    // override bool supports(AuthenticationToken token) {
    //     // warning(typeid(cast(Object)token));
    //     JwtToken t = cast(JwtToken)token;
    //     if(t is null)
    //         return false;
            
    //     tracef("name: %s", t.name());
    //     return t.name() ==  USER_JWT_TOKEN_NAME; 
    // }

    override protected UserService getUserService() {
        return _userService;
    }
}