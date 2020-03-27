module app.middleware.UserAuthMiddleware;

import hunt.framework;
// import hunt.framework.application.MiddlewareInterface;
import hunt.framework.http.Request;
import hunt.framework.http.Response;
import hunt.framework.http.JsonResponse;
import app.component.user.model.User;

import hunt.logging.ConsoleLogger;

import std.algorithm.searching;
import std.uri;

class UserAuthMiddleware : MiddlewareInterface {
    string[] forceLoginMCA = [];
    this() {

    }

    override string name() {
        return UserAuthMiddleware.stringof;
    }

    void setForceLoginMCA(string[] args...) {
        forceLoginMCA = args;
    }

    override Response onProcess(Request request, Response response) {
        bool isVerify = verifyIsLogin(request);
        info("IsLogined: ", isVerify);
        trace(forceLoginMCA);
        warning(request.actionId());
        if(forceLoginMCA.canFind(request.actionId()) && !isVerify)
        {
            Cookie sessionCookie = new Cookie("__auth_token__", "");
            Cookie userCookie = new Cookie("userinfo", "");
            tracef("Redirect..");
            return new RedirectResponse(request, 
                url("user.user.login")).withCookie(sessionCookie).withCookie(userCookie);
        }

        return null;
    }

    private bool verifyIsLogin(Request request) {
        import app.util.JwtUtil;
        import std.conv;

        string token = request.cookie("__auth_token__");
        if (JwtUtil.verify(token, config().application.secret)) {
            return true;
        }
        return false;
    }
}
