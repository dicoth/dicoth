module app.middleware.AdminAuthMiddleware;

import app.auth;
import hunt.framework;

import std.range;


class AdminAuthMiddleware : AuthMiddleware {
    shared static this() {
        MiddlewareInterface.register!(typeof(this));
    }

    this() {
        this.guardName = ADMIN_GUARD_NAME;
        super();
    }

    override protected Response onRejected(Request request) {
        return new RedirectResponse(request, url("system.user.login", null, "admin"));
    }

    override protected JwtToken getToken(Request request) {
        string tokenString = request.bearerToken();

        if(tokenString.empty)
            tokenString = request.cookie(ADMIN_JWT_TOKEN_NAME);

        if(tokenString.empty)
            return null;
        
        return new JwtToken(tokenString, ADMIN_JWT_TOKEN_NAME);
    }
}
