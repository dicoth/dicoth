
import hunt.framework;
import hunt.util.DateTime;
import hunt.logging;

import app.component.system.helper.MyAuthProxy;
import hunt.framework.application.ApplicationConfig;
import hunt.framework.i18n.I18n;
import hunt.framework.security.acl;
import std.datetime.systime;
import std.random;
import std.json;

import hunt.entity.DefaultEntityManagerFactory;
import app.component.system.model.LangPackage;
import app.component.system.repository.LangPackageRepository;
import app.component.system.repository.LanguageRepository;
// import app.middleware.AuthoverrideMiddleware;
import hunt.shiro;
import std.conv;

void main(string[] args)
{
    DateTimeHelper.startClock();
    reloadApplicationByConsoleCommand(args);
    auto app = Application.getInstance();
    
    app.accessManager.initAuthenticateProxy(new MyAuthProxy());


    auto defaultLanguage = configManager().config("hunt").hunt.application.defaultLanguage.value;
    auto langPackageRepository = new LangPackageRepository();
    auto allData = langPackageRepository.initLangPackage();
    I18n i18n = I18n.instance();
    foreach(key, oneArray; allData){
        i18n.merge(key, oneArray);
    }

    app.onBreadcrumbsInitializing((BreadcrumbsManager breadcrumbs) {

        breadcrumbs.register("forum.forum.list", (Breadcrumbs trail, Object[] params...) {
            trail.push("Home", url("forum.forum.list"));
        });

        breadcrumbs.register("forum.forum.forum", (Breadcrumbs trail, Object[] params...) {
            import app.component.forum.model.Forum;
            trail.parent("forum.forum.list");
            if(params)
            {
                Forum forum = cast(Forum)params[0];
                trail.push(forum.name, url("forum.forum.forum", ["id": forum.id.to!string]));
            }else{
                trail.push("Threads list", url("forum.forum.forum"));
            }
        });

        breadcrumbs.register("forum.thread.thread", (Breadcrumbs trail, Object[] params...) {
            import app.component.forum.model.Thread;
            Thread thread = cast(Thread)params[0];
            trail.parent("forum.forum.forum", thread.forum);
            trail.push(thread.title, url("forum.thread.thread"));
        });

        breadcrumbs.register("forum.thread.create", (Breadcrumbs trail, Object[] params...) {
            trail.parent("forum.forum.list");
            trail.push("Publish Thread", url("forum.thread.create"));
        });

        breadcrumbs.register("user.user.profile", (Breadcrumbs trail, Object[] params...) {
            trail.parent("forum.forum.list");
            string title = "User Profile";
            if(params)
            {
                import app.component.user.model.User;
                auto user = cast(User)params[0];

                title = user.nickname ~ "'s Profile";
            }

            trail.push(title, url("user.user.profile"));
        });
    });

    initializeShiro();

    app.run();
}

void reloadApplicationByConsoleCommand(string[] args)
{
    import hunt.util.Argument;

    struct Options
    {
        @Option("env", "e")
        @Help("Load application name.")
        string env;
    }

    Options options;
    try
    {
        options = parseArgs!Options(args[1 .. $]);
        if (options.env != "")
        {
            configManager().setAppSection("", DEFAULT_CONFIG_PATH~"application."~options.env~".conf");
        }
    }
    catch (ArgParseError e)
    {}
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