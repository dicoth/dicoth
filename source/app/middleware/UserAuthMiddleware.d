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

    // // this() {
    // //     super();
    // // }
    
    // override protected JwtToken getToken(Request request) {
    //     string tokenString = request.bearerToken();
    //     string tokenCookieName = request.auth().tokenCookieName();

    //     if(tokenString.empty)
    //         tokenString = request.cookie(tokenCookieName);

    //     if(tokenString.empty)
    //         return null;
    //     return new JwtToken(tokenString, tokenCookieName);
    // }
}