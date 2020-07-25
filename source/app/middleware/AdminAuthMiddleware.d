module app.middleware.AdminAuthMiddleware;

import app.auth;
import hunt.framework;

import std.range;


enum string ADMIN_AUTH_COOKIE_NAME = "__admin_jwt_token__";


class AdminAuthMiddleware : JwtAuthMiddleware {
    shared static this() {
        MiddlewareInterface.register!(typeof(this));
    }

    override protected JwtToken getToken(Request request) {
        string tokenString = request.bearerToken();

        if(tokenString.empty)
            tokenString = request.cookie(ADMIN_AUTH_COOKIE_NAME);

        if(tokenString.empty)
            return null;
        // return new AdminJwtToken(tokenString);
        
        return new JwtToken(tokenString, "admin-jwt-token");
    }
}


// import app.component.system.repository.MenuRepository;
// import app.component.system.repository.UserRepository;
// // import app.component.system.model.Menu;
// import app.component.system.model.User;

// // import hunt.framework.application.Controller;
// import hunt.framework.middleware.MiddlewareInterface;
// import hunt.framework.http.Request;
// import hunt.framework.http.Response;
// import hunt.framework.http.RedirectResponse;
// import hunt.framework.Simplify;

// import hunt.entity.EntityManager;
// import hunt.entity.DefaultEntityManagerFactory;
// import hunt.http.HttpMethod;

// import hunt.logging.ConsoleLogger;
// import hunt.shiro;

// import std.array;
// import std.string;

// class AuthenticationMiddleware : MiddlewareInterface {
//     EntityManager _cManager;

//     this(EntityManager manager)
//     {
//         this._cManager = manager;
//         // _cManager = defaultEntityManagerFactory().createEntityManager();
//     }
    
//     override string name() {
//         return typeof(this).stringof;
//     }

//     override Response onProcess(Request request, Response response) {
        
//         infof("path: %s, method: %s", request.path(), request.method );
//         if(request.path().startsWith("/login") ) { // && request.method == HttpMethod.GET
//             return null;
//         }

//         string sessionId = request.cookie("ShiroSessionId");
//         if(!sessionId.empty) {
//             Subject subject = SecurityUtils.newSubject(sessionId, request.host()); 
//             infof("sessionId: %s, isAuthenticated: %s", sessionId, subject.isAuthenticated());

//             if(subject.isAuthenticated()) {
//                 request.setAttribute(Subject.DEFAULT_NAME, cast(Object)subject);
//                 return null;    

//             }
//         }

//         return new RedirectResponse(request, url("system.user.login", null, "admin"));
//     }

// }