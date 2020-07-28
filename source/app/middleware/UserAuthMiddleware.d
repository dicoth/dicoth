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

    this() {
        super();
    }
    
    override protected JwtToken getToken(Request request) {
        string tokenString = request.bearerToken();
        string tokenCookieName = request.authOptions.tokenCookieName;

        import hunt.logging.ConsoleLogger;
        warningf("request: %s, predefined: %s", tokenCookieName, USER_JWT_TOKEN_NAME);

        if(tokenString.empty)
            tokenString = request.cookie(tokenCookieName);

        if(tokenString.empty)
            return null;
        return new JwtToken(tokenString, tokenCookieName);
    }
}