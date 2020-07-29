module app.providers.DicothAuthServiceProvider;

import app.auth;

import hunt.framework.provider;
import hunt.framework.auth;
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
}