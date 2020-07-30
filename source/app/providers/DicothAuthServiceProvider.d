module app.providers.DicothAuthServiceProvider;

import app.auth;
import app.data.DicothAdminUserService;
import app.data.DicothUserService;

import hunt.framework;
import hunt.shiro;

import hunt.logging.ConsoleLogger;
import poodinis;

class DicothAuthServiceProvider : AuthServiceProvider {
    
    // override void register() {

    //     serviceContainer().register!(AuthorizingRealm, UserBasicAuthRealm).newInstance;
    //     serviceContainer().register!(AuthorizingRealm, UserJwtAuthRealm).newInstance;
        
    //     serviceContainer().register!(AuthorizingRealm, AdminBasicAuthRealm).newInstance;
    //     serviceContainer().register!(AuthorizingRealm, AdminJwtAuthRealm).newInstance;
    // }

    override void boot() {
        AuthService authService = container().resolve!AuthService();
        ApplicationConfig appConfig = container().resolve!ApplicationConfig();
        authService.addGuard(new AdminGuard());
        authService.addGuard(new UserGuard());

        // Guard adminGuard = new Guard(new DicothAdminUserService(), ADMIN_GUARD_NAME);
        // adminGuard.tokenCookieName = ADMIN_JWT_TOKEN_NAME;
        // adminGuard.tokenExpiration = appConfig.auth.tokenExpiration;
        // authService.addGuard(adminGuard);


        // Guard userGuard = new Guard(new DicothUserService(), USER_GUARD_NAME);
        // userGuard.tokenCookieName = USER_JWT_TOKEN_NAME;
        // userGuard.tokenExpiration = appConfig.auth.tokenExpiration;
        // authService.addGuard(userGuard);

        authService.boot();
    }
}