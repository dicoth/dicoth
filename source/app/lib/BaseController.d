module app.lib.BaseController;

import hunt.framework;
public import std.json;
import hunt.http.codec.http.model.HttpMethod;
import hunt.entity.DefaultEntityManagerFactory;
import app.component.user.model.User;
import app.middleware.UserAuthMiddleware;
import hunt.framework.application.ApplicationConfig;
import hunt.util.Configuration;
import std.uri;
import hunt.framework.application.BreadcrumbItem;

import hunt.framework.Simplify;
import app.component.user.repository.UserRepository;
import app.lib.JwtToken;
import app.lib.JwtUtil;
import std.range;
import hunt.shiro;
import app.lib.Exceptions;
public import app.middleware.UserAuthMiddleware;

class BaseController : Controller
{
    EntityManager _cManager;
    protected ConfigBuilder _conf;

    this()
    {
        _cManager = defaultEntityManagerFactory().createEntityManager();
        _conf = configManager().config("hunt");
    }

    override bool before()
    {
        view.assign("route_path", request.path());
        string fullUrl = encodeComponent("http://" ~ request.host() ~ request.url());
        view.assign("passport_profile", "/settings");
        view.assign("author", "DLang Chinese Forum");
        view.assign("keywords", "DLang,D语言,Hunt-Framework,DLangchina,DLang中文论坛");
        string tokenString = request.header(HttpHeader.AUTHORIZATION);
        if(tokenString.empty)
        {
            tokenString = request.cookie("__auth_token__");
        }
        auto baseUserInfo = JwtUtil.getInfo(tokenString);
        view.assign("session_user",baseUserInfo);
        return true;
    }

    override bool after()
    {
        if(_cManager){
            _cManager.close();
        }
        return true;
    }

    int getUserId()
    {
        string jwttoken = request.cookie("__auth_token__");
        auto baseUserInfo = JwtUtil.getInfo(jwttoken);
        if(baseUserInfo !is null){
            return  baseUserInfo.uid;
        }else{
            return  0;
        }

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
