module app.component.system.authentication.AuthenticationMiddleware;

// import app.util.Exceptions;
// // import app.component.system.authentication.JwtToken;

// import app.component.system.repository.MenuRepository;
// import app.component.system.repository.UserRepository;
// // import app.component.system.model.Menu;
// import app.component.system.model.User;

// // import hunt.framework.application.Controller;
// import hunt.framework.auth;
// import hunt.framework.middleware.MiddlewareInterface;
// import hunt.framework.http.Request;
// import hunt.framework.http.Response;
// import hunt.framework.http.RedirectResponse;
// import hunt.framework.Simplify;

// import hunt.entity.EntityManager;
// import hunt.entity.DefaultEntityManagerFactory;
// import hunt.http.HttpMethod;
// import hunt.http.HttpHeader;

// import hunt.logging.ConsoleLogger;
// import hunt.shiro;

// import std.array;
// import std.string;

// import hunt.Exceptions;

// class AuthenticationMiddleware : MiddlewareInterface {

//     this() {
//     }
    
//     override string name() {
//         return typeof(this).stringof;
//     }

//     override Response onProcess(Request request, Response response) {
        
//         infof("path: %s, method: %s, actionId: %s", request.path(), request.method, request.actionId() );
//         if(request.actionId() == "system.user.login") { 
//             return null;
//         }

//         string tokenString = request.header(HttpHeader.AUTHORIZATION);
//         infof("tokenString: %s", tokenString);
//         enum TokenHeader = "Bearer ";
        
//         if(!tokenString.empty) {
//             if(!tokenString.startsWith(TokenHeader)) {
//                 return new RedirectResponse(request, url("system.user.login", null, "admin"));
//             }

//             tokenString = tokenString[TokenHeader.length .. $];
//         }

//         if(tokenString.empty)
//             tokenString = request.cookie("__auth_token__");

//         if(!tokenString.empty) {

//             Subject subject = SecurityUtils.newSubject("", request.host());
//             try {
//                 JwtToken token = new JwtToken(tokenString);
//                 subject.login(token);
//             } catch (WrongPasswordException e) {
//                 warning(e);
//             } catch (AuthenticationException e) {
//                 warning(e);
//             } catch(Exception ex) {
//                 warning(ex);
//             }

//             if(subject.isAuthenticated()) {
//                 request.setAttribute(Subject.DEFAULT_NAME, cast(Object)subject);
//                 return null;	
//             }
//         }

//         return new RedirectResponse(request, url("system.user.login", null, "admin"));
//     }

// }