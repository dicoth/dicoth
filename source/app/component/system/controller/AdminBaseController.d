module app.component.system.controller.AdminBaseController;

import app.auth.Constants;
import app.middleware;

import app.component.system.model.Menu;
import app.component.system.model.User;
import app.component.system.repository.MenuRepository;
import app.component.system.repository.UserRepository;
import app.util.Functions;
import app.component.system.authentication.AuthenticationMiddleware;
import hunt.http.HttpMethod;
import hunt.entity.DefaultEntityManagerFactory;
import hunt.framework;
// import hunt.framework.i18n.I18n;
// import hunt.framework.security.acl.Permission;
// import hunt.framework.Simplify;
import hunt.shiro;
// import app.component.system.authentication.JwtToken;
// import app.component.system.authentication.JwtUtil;
public import std.algorithm;
public import std.conv;
public import std.json;
public import std.string;

import hunt.serialization.JsonSerializer;

class AdminBaseController : Controller {

    protected User thisUser;
    private string[] _alertSuccessMessages;
    private string[] _alertErrorMessages;
    EntityManager _cManager;

    this() {
        _cManager = Application.instance.entityManager();
        addMiddleware(new AdminAuthMiddleware());
    }
    
    BreadcrumbsManager breadcrumbsManager() {
        return Application.instance.breadcrumbs();
    }

    I18n translationManager() {
        return Application.instance.translation();
    }

    override void dispose() {
        // _cManager.close();
        // super.dispose();
    }

    override bool before() {
        if (request.methodAsString() == HttpMethod.OPTIONS.asString())
            return false;

        this.flashMessages();

        import hunt.logging.ConsoleLogger;
        string actionId = request.actionId();
        tracef("actionId: %s", actionId);
        // if(actionId == "system.user.login") {
        //     view.assign("isLogin", "NO");
        //     return true;
        // }

        Identity user = request().auth().user(); // request().bearerToken(); //  
        if(user.isAuthenticated()) {
            import hunt.logging.ConsoleLogger;

            // Claim[] claims =  user.claims;
             // foreach(Claim c; claims) {
            // 	tracef("%s, %s", c.type, c.value);
            // }

            bool r = user.isPermitted("abcd");
            
            string fullName = user.claimAs!(string)(ClaimTypes.FullName);
            auto repository = new MenuRepository();
            view.assign("isLogin", "YES");
            view.assign("username", fullName);
            MenuItemViewModel[] menuData = repository.getAllowdMenus(user);
            view.assign("menusJsonData", menuData);
        } else {
            view.assign("isLogin", "NO");
        }

        // Subject subject = cast(Subject)request.getAttribute(Subject.DEFAULT_NAME);

        // if(subject !is null && subject.isAuthenticated()) {
        // 	auto repository = new MenuRepository();
        // 	view.assign("isLogin", "YES");
        // 	User currentUser = cast(User) subject.getPrincipal();
        // 	assert(currentUser !is null);
        // 	view.assign("nowUser", currentUser);

        // 	MenuItemViewModel[] menuData = repository.getAllowdMenus(subject);
        // 	view.assign("menusJsonData", menuData);

        // } else {
        // 	view.assign("isLogin", "NO");
        // }

        return true;
    }

    void makePageBreadCrumbs (string breadSign) {
        auto breadCrumbs = breadcrumbsManager.generate(breadSign);
        string breadTitle;
        int breadNum = cast(int) breadCrumbs.length;
        if (breadNum > 0) {
            breadTitle = breadCrumbs[breadNum - 1].title;
        }
        view.assign("breadCrumbs", breadCrumbs);
        view.assign("breadTitle", breadTitle);
    }

    Response ResponseView (string viewPath, string lang = "") {
        import hunt.logging.ConsoleLogger;
        lang = lang == "" ? findLocal(request.auth().user()) : lang;
        tracef("lang: %s", lang);
        
        HttpBody hb = HttpBody.create(MimeType.TEXT_HTML_VALUE, view.setLocale(lang).render(viewPath));
        return new Response(hb);

        // return new Response(request)
        // .setHeader(HttpHeader.CONTENT_TYPE, MimeType.TEXT_HTML_UTF_8.asString())
        // .setContent(view.setLocale(lang).render(viewPath));
    }

    override bool after() {
        closeDefaultEntityManager();
        return true;
    }

    bool assignSussess (string msg) {
        if(!canFind(_alertSuccessMessages, msg)) {
            _alertSuccessMessages ~= msg;
            request.session(true).set("successMessages", toJson(_alertSuccessMessages).to!string);
        }
        return true;
    }

    bool assignError (string msg) {
        if(!canFind(_alertErrorMessages, msg)) {
            _alertErrorMessages ~= msg;
            request.session(true).set("errorMessages", toJson(_alertErrorMessages).to!string);
        }
        return true;
    }

    bool flashMessages() {
        HttpSession session = request.session(true);
        string sessionSuccessMessages = session.get("successMessages");
        string sessionErrorMessages = session.get("errorMessages");
        if(sessionSuccessMessages) {
            session.remove("successMessages");
            view.assign("successMessages", parseJSON(sessionSuccessMessages).array);
        }
        if(sessionErrorMessages) {
            session.remove("errorMessages");
            view.assign("errorMessages", parseJSON(sessionErrorMessages).array);
        }
        return true;
    }

    string getEmail()
    {
        Identity user = request().auth().user();
        return user.name();
    }

}
