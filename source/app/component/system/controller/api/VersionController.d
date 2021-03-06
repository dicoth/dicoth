module app.component.system.controller.api.VersionController;

import hunt.framework;

import hunt.util.Serialize;

class VersionController : Controller
{
    mixin MakeController;

    @Action Response check()
    {
        import app.component.system.message.VersionMessage;

        auto message = new VersionMessage;
        
        message.id = 10001;
        message.description = "test version";
        message.released = 1234567890;

        // HttpBody hb = HttpBody.create(MimeType.TEXT_HTML_VALUE, view.render("forum/admin/edit"));
        return new Response();
        // auto res = new Response(request);
        // res.json(toJson(message));

        // return res;
    }
}
