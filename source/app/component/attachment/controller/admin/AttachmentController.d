module app.component.attachment.controller.admin.AttachmentController;

import hunt.framework;
import hunt.http.HttpBody;
import hunt.logging.ConsoleLogger;
import hunt.http.server.HttpServerResponse;

import app.component.attachment.form.AttachmentForm;
import app.component.attachment.model.Attachment;
import app.component.user.model.User;
import app.component.attachment.repository.AttachmentRepository;
import app.component.user.repository.UserRepository;
import app.util.PageModel;
import app.component.system.controller.AdminBaseController;
// import app.util.NotFoundResponse;

import app.util.Functions;
import std.conv;

class AttachmentController : AdminBaseController
{
    mixin MakeController;

    this() {
        super();
        
    }
        
    @Action Response list(string k = "", int page = 1)
    {
        int limit = 20;
        string nickName = k;
        int uid = 0;
        if(nickName){
            auto userInfo = new UserRepository(_cManager).findUserByNickname(nickName);
            if(userInfo){
                uid = userInfo.id;
            }
        }
        auto data = (new AttachmentRepository(_cManager)).findPageByAttachment(uid, page-1, limit);

        view.assign("uid", uid);
        view.assign("attachments", data.getContent());

        view.assign("pageModel",  data.getModel());
        view.assign("pageQuery", buildQueryString(request.input()));

        // HttpServerResponse r = new HttpServerResponse();
		// HttpBody hb = HttpBody.create(MimeType.TEXT_HTML_UTF_8.toString(), view.render("attachment/attachment/list"));
        // r.setBody(hb);
        // return r;
        Response r = new Response();
        r.setContent(view.render("attachment/attachment/list"), MimeType.TEXT_HTML_UTF_8.toString());
        return r;
    }



    @Action Response audit(int id)
    {

        auto repo = new AttachmentRepository(_cManager);

        auto attachment = repo.find(id);

        view.assign("attachment",attachment);
        int audit = 0;
        //if(attachment.deleted > 0){
        //    audit = 3;
        //}else if(attachment.audited > 0 && attachment.status == 1){
        //    audit = 1;
        //}else if(attachment.audited > 0 && attachment.status == 0){
        //    audit = 2;
        //}
        if(attachment.status == 1)
        {
            audit = 1;
        }
        else if(attachment.status == 2)
        {
            audit = 2;
        }
        else if(attachment.status == 3)
        {
            audit = 3;
        }
        view.assign("audit", audit); 
        logError(url("admin:attachment.attachment"));
        view.assign("url",url("admin:attachment.attachment"));  
        
        // HttpServerResponse r = new HttpServerResponse();
		// HttpBody hb = HttpBody.create(MimeType.TEXT_HTML_UTF_8.toString(), view.render("attachment/attachment/edit"));
        // r.setBody(hb);
        // return r;
        Response r = new Response();
        r.setHtmlContent(view.render("attachment/attachment/edit"));
        return r;
    }

    @Action Response doAudit(AttachmentForm form)
    {
        int id = request.post("id").to!int;
        auto now = cast(int) time();
        auto repo = new AttachmentRepository(_cManager);
        auto attachment = repo.find(id);

       if(form.audit == 1)
       {
           attachment.status = 1;
       }

        if(form.audit == 2)
        {
            attachment.status = 2;  
        }

        if(form.audit == 3)
        {
            attachment.status = 3;
        }
        repo.saveAttachmentData(attachment);
        return new RedirectResponse(request, url("admin:attachment.attachment.list"));

    }

    @Action Response del(int id)
    {
        auto now = cast(int) time();

        auto det = (new AttachmentRepository(_cManager)).DelByPost(id, now);
        
        return new RedirectResponse(request, url("admin:attachment.attachment.list"));
    }

    @Action Response attachmentFile(int id)
    {
        FileResponse response;

        auto fileRepository = new AttachmentRepository(_cManager);
        auto file = fileRepository.find(id);
        if(file)
        {
            import app.util.yun.FileCloud;

            auto fileCloud = new FileCloud();
            string path = fileCloud.getLocalFilePath(file.filename);
            try
            {
                response = new FileResponse(path);
                response.setMimeType(file.mime);
                response.header("Cache-Control", "max-age=86400");
                response.header("content-type", file.mime);
                response.setName(file.original_name);

                response.loadData();
                if(file.extension == ".gif" || file.extension != ".jpg" || file.extension != ".png" || file.extension != "jpeg")
                {
                    response.header("Content-Disposition", "");
                }
                file.downloads += 1;
                fileRepository.save(file);
            }
            catch(Exception e)
            {
                return new NotFoundResponse;
            }
        }
        else
        {
            return new NotFoundResponse;
        }

        return response;
    }

    

           

}