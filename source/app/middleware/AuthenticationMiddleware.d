module app.middleware.AuthenticationMiddleware;

import app.component.system.repository.MenuRepository;
import app.component.system.repository.UserRepository;
// import app.component.system.model.Menu;
import app.component.system.model.User;

// import hunt.framework.application.Controller;
import hunt.framework.application.MiddlewareInterface;
import hunt.framework.http.Request;
import hunt.framework.http.Response;
import hunt.framework.http.RedirectResponse;
import hunt.framework.Simplify;

import hunt.entity.EntityManager;
import hunt.entity.DefaultEntityManagerFactory;
import hunt.http.codec.http.model.HttpMethod;

import hunt.logging.ConsoleLogger;
import hunt.shiro;

import std.array;
import std.string;

class AuthenticationMiddleware : MiddlewareInterface {
    EntityManager _cManager;

    this(EntityManager manager)
    {
        this._cManager = manager;
        // _cManager = defaultEntityManagerFactory().createEntityManager();
    }
    
    override string name() {
        return typeof(this).stringof;
    }

    override Response onProcess(Request request, Response response) {
        
        infof("path: %s, method: %s", request.path(), request.method );
        if(request.path().startsWith("/login") ) { // && request.method == HttpMethod.GET
            return null;
        }

        string sessionId = request.cookie("ShiroSessionId");
        if(!sessionId.empty) {
            Subject subject = SecurityUtils.newSubject(sessionId, request.host()); 
            infof("sessionId: %s, isAuthenticated: %s", sessionId, subject.isAuthenticated());

            if(subject.isAuthenticated()) {
                request.setAttribute(Subject.DEFAULT_NAME, cast(Object)subject);
                return null;    

            }
        }

        return new RedirectResponse(request, url("system.user.login", null, "admin"));
    }

}