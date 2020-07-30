module app.util.BaseController;

import app.auth.Constants;

import app.component.user.repository.UserRepository;
import app.component.user.model.User;
import app.util.Exceptions;

import jwt;

// import app.util.JwtToken;
// import app.util.JwtUtil;

import hunt.framework;
import hunt.entity.DefaultEntityManagerFactory;
import hunt.http.HttpMethod;
import hunt.logging.ConsoleLogger;
import hunt.shiro;
import hunt.util.Configuration;
import hunt.util.Serialize;

public import std.json;
import std.conv;
import std.uri;
import std.range;


class JwtUserInfo
{
    string nickname;
    int uid;
    string username;
    string avatar;
}


class BaseController : Controller
{
    EntityManager _cManager;
    // protected ConfigBuilder _conf;

    this()
    {
		_cManager = Application.instance.entityManager();
        // _cManager = defaultEntityManagerFactory().currentEntityManager();
        // _conf = configManager().config("hunt");
        // this.tokenCookieName = USER_JWT_TOKEN_NAME;
        // this.authenticationScheme = AuthenticationScheme.Bearer;

        // AuthOptions options = new AuthOptions();
        // options.tokenCookieName = USER_JWT_TOKEN_NAME;
        // // options.scheme = AuthenticationScheme.Bearer;
        // options.guardName = USER_GUARD_NAME;
        // options.tokenExpiration = config().auth.tokenExpiration;
        
        // this.authOptions = options;        
    }

    hunt.cache.Cache.Cache cache() {
        return Application.instance.cache();
    }

    override bool before()
    {
        view.assign("route_path", request.path());
        string fullUrl = encodeComponent("http://" ~ request.host() ~ request.url());
        view.assign("passport_profile", "/settings");
        view.assign("author", "DLang Chinese Forum");
        view.assign("keywords", "DLang,D语言,Hunt-Framework,DLangchina,DLang中文论坛");

        // Auth auth = request().auth();
        // auth.d

        string tokenString = request().auth().token(); // request().bearerToken(); //  
        // if(tokenString.empty)
        // {
        //     tokenString = request.cookie(USER_AUTH_COOKIE_NAME);
        // }

        version(HUNT_DEBUG) warning("xxxx tokenString=>", tokenString);

        if(!tokenString.empty) {
            auto baseUserInfo = getInfo(tokenString);
            view.assign("session_user",baseUserInfo);
        }
        return true;
    }

    static JwtUserInfo getInfo(string token) {
        JwtUserInfo userInfo;
        try {
            Token tk = jwt.decode(token);
            // Claims userClaims = tk.claims();

            string jStr = tk.claims().json();
            warning("claims: ", jStr);
            // return toObject!JwtUserInfo(parseJSON(jStr));

            userInfo = new JwtUserInfo();
            userInfo.username = tk.claims().sub();
            userInfo.avatar = tk.claims().get("avatar");
            string uid = tk.claims().get("user_id");
            if(!uid.empty) {
                try {
                    userInfo.uid = uid.to!int;
                } catch(Exception ex) {
                    warning(ex.msg);
                }
            }
            return userInfo;

        } catch (Exception e) {
            warning(e);
            return null;
        }
    }

    // override bool after()
    // {
    //     if(_cManager){
    //         _cManager.close();
    //     }
    //     return true;
    // }

    BreadcrumbsManager breadcrumbsManager() {
        return Application.instance.breadcrumbs();
    }

    int getUserId()
    {
        return cast(int)request.auth().user().id();
    }

    string breadcrumbsToTitle(BreadcrumbItem[] items)
    {
        string title = "";

        int i = 1;
        foreach_reverse(item; items)
        {
            title ~= ( i == 1 ? "" : " - ") ~ (items.length == i ? config().application.name : item.title);
            i++;
        }

        return title;
    }

    override void dispose() {
        closeDefaultEntityManager();
    }
}
