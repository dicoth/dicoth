module app.component.user.controller.admin.UserController;

import hunt.framework;

import app.component.user.model.User;
import app.component.user.repository.UserRepository;
import app.lib.PageModel;
import app.component.system.controller.AdminBaseController;
import app.lib.Functions;

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

        return new Response(request)
        .setHeader(HttpHeader.CONTENT_TYPE, MimeType.TEXT_HTML_UTF_8.asString())
        .setContent(view.render("user/user/list"));
    }


    @Action Response detailed(int id)
    {
        auto data = (new UserRepository(_cManager)).find(id);
        

        view.assign("user", data);
        
        return new Response(request)
        .setHeader(HttpHeader.CONTENT_TYPE, MimeType.TEXT_HTML_UTF_8.asString())
        .setContent(view.render("user/user/detailed"));

    }
    
}