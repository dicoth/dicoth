module app.providers.DicothAuthServiceProvider;

import app.auth;
import app.data.DicothAdminUserService;
import app.data.DicothUserService;

import hunt.framework;
import hunt.shiro;

import hunt.logging.ConsoleLogger;
import poodinis;

class DicothAuthServiceProvider : AuthServiceProvider {
    
    override void boot() {
        AuthService authService = container().resolve!AuthService();
        // ApplicationConfig appConfig = container().resolve!ApplicationConfig();
        authService.addGuard(new AdminGuard());
        authService.addGuard(new UserGuard());

        authService.boot();
    }
}