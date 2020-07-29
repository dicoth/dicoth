module app.auth.UserGuard;

import app.auth.Constants;
import app.data.DicothUserService;
import hunt.framework;

/**
 * 
 */
class UserGuard : Guard {
    this() {
        super(new DicothUserService(), USER_GUARD_NAME);
    }
}