

import app.auth;
import app.providers;
import app.component.system.model.LangPackage;
import app.component.system.repository.LangPackageRepository;
import app.component.system.repository.LanguageRepository;

import hunt.framework;
import hunt.logging.ConsoleLogger;

import app.middleware.AdminAuthMiddleware;

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
    
    app.register!DicothAuthServiceProvider; 
    app.register!DicothBreadcrumbServiceProvider; 

    app.onBooted(() {

        // AuthService authService = app.auth();
        
        // authService.addGuard(new AdminGuard());
        // authService.addGuard(new UserGuard());
        // authService.boot();


        TypeInfo_Class[string] all = MiddlewareInterface.all();
        foreach(string key, TypeInfo_Class typeInfo; all) {
            infof("Registed middleware: %s => %s", key, typeInfo.toString());
        }

        RouteGroup adminGroup = app.route().group("admin");
        adminGroup.guardName = ADMIN_GUARD_NAME;
        // adminGroup.withMiddleware(AdminAuthMiddleware.stringof);
        // adminGroup.get("system.user.login").withoutMiddleware(AdminAuthMiddleware.stringof); 

        RouteGroup userGroup = app.route().group();
        userGroup.guardName = USER_GUARD_NAME;

        // app.route().get("index.about").withoutMiddleware!(JwtAuthMiddleware)();

        // app.route().group("admin").withMiddleware(JwtAuthMiddleware.stringof);
        // app.route().group("admin").get("index.test").withoutMiddleware(JwtAuthMiddleware.stringof);        
    });  

    app.run(args);
}
