module app.ShiroHuntCacheManager;

import app.ShiroHuntCache;

import hunt.shiro.cache.AbstractCacheManager;
import hunt.shiro.authz.AuthorizationInfo;
import hunt.cache.Cache;
import hunt.shiro.cache.Cache;

import hunt.logging.ConsoleLogger;

alias ShiroCache = hunt.shiro.cache.Cache.Cache;
alias HuntCache = hunt.cache.Cache.Cache;

class ShiroHuntCacheManager : AbstractCacheManager!(Object, AuthorizationInfo) {

    // private RedisTemplate<byte[],byte[]> redisTemplate;
    private HuntCache _cache;

    this(HuntCache cache){
        _cache = cache;
    }

    override protected ShiroHuntCache createCache(string name) {
        return new ShiroHuntCache(name, _cache);
    }
}