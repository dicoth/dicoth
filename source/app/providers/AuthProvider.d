module app.providers.AuthProvider;

import common;
import app.component.system.authentication.AdminCmsRealm;
import app.ShiroHuntCacheManager;

import hunt.cache.Cache;
import hunt.framework.provider.ServiceProvider;
import hunt.framework.provider.AuthServiceProvider;
import hunt.framework.application;
import hunt.shiro;

import hunt.logging.ConsoleLogger;

import std.conv;

alias ShiroCache = hunt.shiro.cache.Cache.Cache;
alias HuntCache = hunt.cache.Cache.Cache;

/**
 * 
 */
class AuthProvider : AuthServiceProvider {

    override void boot() {

        HuntCache cache = serviceContainer().resolve!HuntCache();

        warning("shiro ................");
        AdminCmsRealm realm2 = new AdminCmsRealm();
        DefaultSecurityManager sm2 = new DefaultSecurityManager();
        sm2.setRealm(realm2);
        CacheManager cacheManager2 = new ShiroHuntCacheManager(cache);
        sm2.setCacheManager(cacheManager2);
        SecurityUtils.setSecurityManager(sm2);
    }
}