module app.middleware.UserAuthMiddleware;

import hunt.framework;
import hunt.framework.application.MiddlewareInterface;
import hunt.framework.http.Request;
import hunt.framework.http.Response;
import hunt.framework.http.JsonResponse;
import app.component.user.model.User;
import std.algorithm.searching;
import std.net.curl;
import std.uri;

class UserAuthMiddleware : MiddlewareInterface
{
    public string[] forceLoginMCA = [];
    this()
    {

    }

    override string name()
    {
        return UserAuthMiddleware.stringof;
    }

    void setForceLoginMCA(string[] args ...)
    {
        forceLoginMCA = args;
    }

    override Response onProcess(Request request, Response response)
    {
        bool isVerify = this.verifyIsLogin();
        logError(isVerify);
        if(canFind(forceLoginMCA, request.getMCA()) && isVerify == false)
        {
            Cookie sessionCookie = new Cookie("__auth_token__", "");
            Cookie userCookie = new Cookie("userinfo", "");
            import hunt.framework.Simplify;
            return new RedirectResponse(request, url("user.user.login")).withCookie(sessionCookie).withCookie(userCookie);
        }
        if(isVerify == false)
        {
            Cookie sessionCookie = new Cookie("__auth_token__", "");
            Cookie userCookie = new Cookie("userinfo", "");
            response.withCookie(sessionCookie).withCookie(userCookie);
            return null;
        }
        return null;
    }

    public bool verifyIsLogin(){
        import app.lib.JwtUtil;
        import std.conv;

        if(JwtUtil.verify(request.cookie("__auth_token__"), configManager().config("hunt").hunt.application.secret.value))
        {
            return true;
        }
        return false;
    }
}
