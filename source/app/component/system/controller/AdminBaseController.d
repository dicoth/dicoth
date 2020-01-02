module app.component.system.controller.AdminBaseController;

import app.component.system.model.Menu;
import app.component.system.model.User;
import app.component.system.repository.MenuRepository;
import app.component.system.repository.UserRepository;
import app.lib.Functions;
import app.component.system.authentication.AuthenticationMiddleware;
import hunt.http.codec.http.model.HttpMethod;
import hunt.entity.DefaultEntityManagerFactory;
import hunt.framework;
import hunt.framework.security.acl.Permission;
import hunt.framework.Simplify;
import hunt.shiro;
import app.component.system.authentication.JwtToken;
import app.component.system.authentication.JwtUtil;
public import std.algorithm;
public import std.conv;
public import std.json;
public import std.string;

class AdminBaseController : Controller {

	protected User thisUser;
	private string[] _alertSuccessMessages;
	private string[] _alertErrorMessages;
	EntityManager _cManager;
	this() {
		_cManager = defaultEntityManager();
		addMiddleware(new AuthenticationMiddleware());
	}

	override void dispose() {
		// _cManager.close();
		// super.dispose();
	}

	override bool before() {
		this.flashMessages();

		Subject subject = cast(Subject)request.getAttribute(Subject.DEFAULT_NAME);

		if(subject !is null && subject.isAuthenticated()) {
			auto repository = new MenuRepository();
			view.assign("isLogin", "YES");
			User currentUser = cast(User) subject.getPrincipal();
			assert(currentUser !is null);
			view.assign("nowUser", currentUser);

			MenuItemViewModel[] menuData = repository.getAllowdMenus(subject);
			view.assign("menusJsonData", menuData);

		} else {
			view.assign("isLogin", "NO");
		}

		if (request.methodAsString() == HttpMethod.OPTIONS.asString())
			return false;
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
		lang = lang == "" ? findLocal() : lang;
		return new Response(request)
		.setHeader(HttpHeader.CONTENT_TYPE, MimeType.TEXT_HTML_UTF_8.asString())
		.setContent(view.setLocale(lang).render(viewPath));
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
        string jwttoken = request.cookie("__auth_token__");
        auto email = JwtUtil.getUsername(jwttoken);
        if(email !is null){
            return  email;
        }else{
            return  "";
        }
    }

}
