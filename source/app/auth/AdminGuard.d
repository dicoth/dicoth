module app.auth.AdminGuard;

import app.auth.Constants;
import app.data.DicothAdminUserService;
import hunt.framework;

/**
 * 
 */
class AdminGuard : Guard {
    this() {
        super(new DicothAdminUserService(), ADMIN_GUARD_NAME);
    }
}