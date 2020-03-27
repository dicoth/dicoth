module app.providers.DicothAuthServiceProvider;

import app.component.system.authentication.AdminCmsRealm;
import hunt.framework.auth;

import hunt.cache.Cache;
import hunt.framework.provider.ServiceProvider;
import hunt.framework.provider.AuthServiceProvider;
import hunt.framework.application;
import hunt.logging.ConsoleLogger;
import hunt.shiro;

import poodinis;

import std.conv;

alias ShiroCache = hunt.shiro.cache.Cache.Cache;
alias HuntCache = hunt.cache.Cache.Cache;

/**
 * 
 */
class DicothAuthServiceProvider : AuthServiceProvider
{
    override void register() {
        serviceContainer().register!(AuthorizingRealm, AdminCmsRealm).newInstance;
    }
}
