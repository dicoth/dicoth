module app.providers.DicothUserServiceProvider;

import app.data.DicothUserService;

import hunt.framework.provider.UserServiceProvider;
import hunt.framework.auth.UserService;

import hunt.logging.ConsoleLogger;
import poodinis;


/**
 * 
 */
class DicothUserServiceProvider : UserServiceProvider {
    
    override void register() {
        container.register!(UserService, DicothUserService).singleInstance();
    }
}
