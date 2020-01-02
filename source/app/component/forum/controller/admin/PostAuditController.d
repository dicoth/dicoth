module app.component.forum.controller.admin.PostAuditController;

import app.lib.PageModel;
import app.component.forum.form.PostAuditForm;
import app.component.forum.model.Post;
import app.component.forum.repository.PostRepository;
import app.component.system.controller.AdminBaseController;

import app.lib.Functions;
import hunt.logging;
import hunt.framework;
import std.stdio;
import std.conv;

class  PostAuditController  : AdminBaseController
{
   mixin MakeController;
   
   this()
   {
      super();
   }
   
   @Action Response list(int threadId, int uid, int page = 1, string s = "", string n = "")
   {
      int limit = 20;
      string subject = s;
      string nickname = n;
      auto data = (new PostRepository( _cManager)).findPageByPost(threadId, uid, page-1, limit, subject, nickname);
   
      view.assign( "threadId", threadId);
      view.assign( "uid", uid);
      view.assign( "posts", data.getContent());
      view.assign("pageModel",  data.getModel());
      view.assign("pageQuery", buildQueryString(request.input()));


      return new Response( request)
      .setHeader( HttpHeader.CONTENT_TYPE, MimeType.TEXT_HTML_UTF_8.asString())
      .setContent( view.render( "forum/postaudit/list"));
   
   }
   
   
   @Action Response audit(int id)
   {
   
      auto repo = new PostRepository( _cManager);
   
      auto post = repo.find( id);
   
      view.assign( "post",post);
      int audit = 0;
      if (post.deleted > 0){
          audit = 3;
      }else if (post.audited > 0 && post.status == 1){
          audit = 1;
      }else if (post.audited > 0 && post.status == 0){
          audit = 2;
      }
      view.assign( "audit", audit);
   
   
      return new Response( request)
      .setHeader( HttpHeader.CONTENT_TYPE, MimeType.TEXT_HTML_UTF_8.asString())
      .setContent( view.render( "forum/postaudit/edit"));
   }
   
   @Action Response doAudit(PostAuditForm form)
   {
      int id = request.post( "id").to!int;
      auto now = cast(int) time();
      auto repo = new PostRepository( _cManager);
      auto post = repo.find( id);
   
      if (form.audit == 1)
      {
          post.audited = now;
          post.status = 1;
      }
   
      if (form.audit == 2)
      {
          post.audited = now;
          post.status = 0;
          post.deleted = 0;
      }
   
      if (form.audit == 3)
      {
          post.audited = now;
          post.status = 1;
          post.deleted = now;
      }     
      repo.savePostData( post);
      return new RedirectResponse( request, url( "admin:forum.postaudit.list")); 
   }
   
   @Action Response del(int id)
   {
      auto now = cast(int) time();
   
      auto det = (new PostRepository( _cManager)).DelByPost( id, now);
   
      this.assignSussess( "Deleted successfully");
   
      return new RedirectResponse( request, url( "admin:forum.postaudit.list"));
   }

}

