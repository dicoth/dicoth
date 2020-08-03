module app.middleware.UserAuthMiddleware;

import app.auth;
import hunt.framework;
import std.range;


/**
 * 
 */
class UserAuthMiddleware : AuthMiddleware {
    shared static this() {
        MiddlewareInterface.register!(typeof(this));
    }

    // override protected Response onRejected(Request request) {
    //     return new RedirectResponse(request, url("system.user.login", null, "admin"));
    // }

}