
import app.providers;
import app.component.system.model.LangPackage;
import app.component.system.repository.LangPackageRepository;
import app.component.system.repository.LanguageRepository;


// import app.component.system.helper.MyAuthProxy;
import hunt.framework.application.ApplicationConfig;
import hunt.framework.i18n.I18n;
// import hunt.framework.security.acl;

// import app.middleware.AuthoverrideMiddleware;

// import hunt.entity.DefaultEntityManagerFactory;
import hunt.framework;
import hunt.logging;
import hunt.shiro;
import hunt.util.DateTime;

import std.datetime.systime;
import std.random;
import std.json;
import std.conv;

void main(string[] args)
{

    Application app = Application.instance();
    
    // app().accessManager.initAuthenticateProxy(new MyAuthProxy());

    // TODO: Tasks pending completion -@zhangxueping at 2020-03-03T16:05:50+08:00
    // 
    // auto langPackageRepository = new LangPackageRepository();
    // auto allData = langPackageRepository.initLangPackage();
    // I18n i18n = I18n.instance();
    // foreach(key, oneArray; allData){
    //     i18n.merge(key, oneArray);
    // }
    
    app.register!BreadcrumbProvider; 

    initializeShiro();

    app.run(args);
}

void initializeShiro() {
    import common;
    import app.component.system.authentication.AdminCmsRealm;
    

    AdminCmsRealm realm2 = new AdminCmsRealm();
    DefaultSecurityManager sm2 = new DefaultSecurityManager();
    sm2.setRealm(realm2);
    auto cacheManager2 = new MemoryConstrainedCacheManager!(Object, AuthorizationInfo)();
    sm2.setCacheManager(cacheManager2);
    SecurityUtils.setSecurityManager(sm2);
}