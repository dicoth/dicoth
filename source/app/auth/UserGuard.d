module app.auth.UserGuard;

import app.auth.Constants;
import app.data.DicothUserService;
import hunt.framework;

/**
 * 
 */
class UserGuard : JwtGuard {
    this() {
        super(new DicothUserService(), USER_GUARD_NAME);
        this.tokenCookieName = USER_JWT_TOKEN_NAME;
    }
}