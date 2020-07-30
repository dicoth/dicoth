module app.auth.AdminGuard;

import app.auth.Constants;
import app.data.DicothAdminUserService;
import hunt.framework;

/**
 * 
 */
class AdminGuard : JwtGuard {
    this() {
        super(new DicothAdminUserService(), ADMIN_GUARD_NAME);
        this.tokenCookieName = ADMIN_JWT_TOKEN_NAME;
    }

}