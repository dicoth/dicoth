module app.middleware.AdminAuthMiddleware;

import app.auth;
import hunt.framework;

import std.range;


class AdminAuthMiddleware : AuthMiddleware {
    shared static this() {
        MiddlewareInterface.register!(typeof(this));
    }

    this() {
        super();
    }

    override protected Response onRejected(Request request) {
        return new RedirectResponse(request, url("system.user.login", null, "admin"));
    }

    override protected JwtToken getToken(Request request) {
        string tokenString = request.bearerToken();
        string tokenCookieName = request.authOptions.tokenCookieName;

        if(tokenString.empty)
            tokenString = request.cookie(tokenCookieName);

        if(tokenString.empty)
            return null;
        
        return new JwtToken(tokenString, tokenCookieName);
    }
}
