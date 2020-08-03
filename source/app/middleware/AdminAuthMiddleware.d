module app.middleware.AdminAuthMiddleware;

import app.auth;
import hunt.framework;

import hunt.logging.ConsoleLogger;

import std.range;


class AdminAuthMiddleware : AuthMiddleware {
    shared static this() {
        MiddlewareInterface.register!(typeof(this));
    }

    override protected bool onAccessable(Request request) {
        return true;
    }

    override protected Response onRejected(Request request) {
        return new RedirectResponse(request, url("system.user.login", null, "admin"));
    }
}
