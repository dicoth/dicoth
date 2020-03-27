module app.component.user.controller.admin.UserController;

import hunt.framework;

import app.component.user.model.User;
import app.component.user.repository.UserRepository;
import app.util.PageModel;
import app.component.system.controller.AdminBaseController;
import app.util.Functions;

class UserController : AdminBaseController
{
    mixin MakeController;

    this() {
        super();
    }

    @Action Response list(int perPage, int page = 1,string k = "")
    {
        string keyWord = k;
        perPage = perPage < 1 ? 10 : perPage;

        auto alldata = (new UserRepository(_cManager)).findPageByUser(keyWord, page-1, perPage);

        view.assign("users", alldata.getContent());
        view.assign("pageModel",  alldata.getModel());
        view.assign("pageQuery", buildQueryString(request.input()));
        
        HttpBody hb = HttpBody.create(MimeType.TEXT_HTML_VALUE, view.render("user/user/list"));
        return new Response(hb);
        // return new Response(request)
        // .setHeader(HttpHeader.CONTENT_TYPE, MimeType.TEXT_HTML_UTF_8.asString())
        // .setContent(view.render("user/user/list"));
    }


    @Action Response detailed(int id)
    {
        auto data = (new UserRepository(_cManager)).find(id);
        view.assign("user", data);

        HttpBody hb = HttpBody.create(MimeType.TEXT_HTML_VALUE, view.render("user/user/detailed"));
        return new Response(hb);        
        // return new Response(request)
        // .setHeader(HttpHeader.CONTENT_TYPE, MimeType.TEXT_HTML_UTF_8.asString())
        // .setContent(view.render("user/user/detailed"));

    }
    
}