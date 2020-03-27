module app.component.forum.controller.ForumController;

import hunt.framework;
// import hunt.framework.application.BreadcrumbsManager;
import app.util.BaseController;
import app.util.NotFoundResponse;
import app.component.forum.repository.ForumRepository;
import app.component.forum.repository.ThreadRepository;
import app.component.forum.repository.PostRepository;
import app.component.user.repository.UserRepository;
import app.component.attachment.repository.AttachmentRepository;
import app.util.Functions;



class ForumController : BaseController
{
    mixin MakeController;

    this() {
        super();
        auto middle = new UserAuthMiddleware();
        this.addMiddleware(middle);
    }

    @Action
    Response list()
    {
        auto forumRepository = new ForumRepository(_cManager);
        auto threadRepository = new ThreadRepository(_cManager);
        auto forums = forumRepository.findAllByUsable();
        auto threads = threadRepository.findNewestByForum(forums);

        view.assign("forums", forums);
        view.assign("threads", threads);

        import app.component.forum.model.Thread;
        import app.component.user.model.User;
        import hunt.logging.ConsoleLogger;

        Thread[] ts = threadRepository.hot(10);
        // view.assign("hotThreads", cast(Thread[])null);
        view.assign("hotThreads", ts);

        auto breadcrumbs = breadcrumbsManager.generate("forum.forum.list");
        view.assign("breadcrumbs", breadcrumbs);
        view.assign("title", breadcrumbsToTitle(breadcrumbs));

        // return view.render("forum/forum_list");
        
        HttpBody hb = HttpBody.create(MimeType.TEXT_HTML_VALUE, view.render("forum/forum_list"));
        return new Response(hb);
    }

    
    @Action
    Response forum(int id, int page)
    {
        int limit = 10;

        if (page < 1)
        {
            page = 1;
        }

        import app.component.forum.model.Forum;

        Forum forum;

        auto forumRepository = new ForumRepository(_cManager);
        if(id > 0)
        {
            forum = forumRepository.findUsableById(id);
            if(!forum)
            {
                return new NotFoundResponse();
            }
        }
        else
        {
            return new NotFoundResponse();
        }

        auto threadRepository = new ThreadRepository(_cManager);
        auto threadsPage = threadRepository.findAllByForumId(id, page, limit);
        auto userRepository = new UserRepository(_cManager);      
        auto threadsContent = threadsPage.getContent();
        foreach(threadContent; threadsContent){
            if(threadContent.last_uid){
                auto userInfo = userRepository.findUserInfo(threadContent.last_uid);
                if(userInfo){
                threadContent.last_user.nickname = userInfo.nickname;
                }
            }     
        }
        view.assign("forum", forum);
        view.assign("threads", threadsContent);

        view.assign("pageModel",  threadsPage.getModel());
        view.assign("pageQuery", buildQueryString(request.input()));
        view.assign("paginateHtml",  view.render("paginate"));

        auto breadcrumbs = breadcrumbsManager.generate("forum.forum.forum", forum);
        view.assign("breadcrumbs", breadcrumbs);
        view.assign("title", breadcrumbsToTitle(breadcrumbs));
        
		// HttpBody hb = HttpBody.create(MimeType.TEXT_HTML_VALUE, view.render("forum/forum_forum"));

		Response response = new Response();
        // response.withBody(hb);
        
        response.header(HttpHeader.CONTENT_TYPE, MimeType.TEXT_HTML_UTF_8.asString());
        response.setContent(view.render("forum/forum_forum"));
        return response;
    }
    
}
