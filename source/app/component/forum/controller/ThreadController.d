module app.component.forum.controller.ThreadController;

import hunt.framework;
import hunt.logging;
import hunt.framework.application.BreadcrumbsManager;

import app.lib.BaseController;
import app.lib.NotFoundResponse;
import app.middleware.UserAuthMiddleware;

import app.component.attachment.repository.AttachmentRepository;
import app.component.attachment.model.Attachment;

import app.component.forum.repository.ForumRepository;
import app.component.forum.repository.ThreadRepository;
import app.component.forum.repository.PostRepository;
import app.component.user.repository.UserRepository;

import app.component.forum.model.Thread;
import app.component.forum.model.Post;

import std.algorithm.searching;
import std.regex;
import app.lib.Functions;

import app.component.forum.form.Post;

import std.array;
import std.conv;


class ThreadController : BaseController
{
    mixin MakeController;

    this() {
        super();
        auto middle = new UserAuthMiddleware();
        middle.setForceLoginMCA(["forum.thread.create", "forum.thread.editpage", "forum.thread.edit", "forum.thread.reply"]);
        this.addMiddleware(middle);
    }

    @Action
    Response thread(int id)
    {   
        auto threadRepository = new ThreadRepository(_cManager);
        auto userRepository = new  UserRepository(_cManager);
        auto thread = threadRepository.findUsableById(id);
        if(!thread)
        {
            return new NotFoundResponse();
        }
        if(!thread.forum)
        {
            return new NotFoundResponse();
        }
        int last_uid = thread.last_uid;
        auto lastUserInfo = userRepository.findById(last_uid);
        if(lastUserInfo){
            thread.last_user = lastUserInfo;
        }else{
            return new NotFoundResponse();
        }
        
        if(id){
            string cookie_thread = "thread"~id.to!string;
            string is_read = request.cookie(cookie_thread);
            if(!is_read){
                Cookie threadCookie = new Cookie(cookie_thread, "1",3600);
                new Response(request).withCookie(threadCookie);
                threadRepository.read(thread);
            }
        }
        
        auto threadInfo = threadRepository.findById(id);
        
        if(!threadInfo){
            return new NotFoundResponse();
        }
        
        int threadUserId = threadInfo.uid;
        
        auto threadUserInfo = userRepository.findById(threadUserId);
        
        if(!threadUserInfo){
            return new NotFoundResponse();
        }
        
        view.assign("thread", thread);
        
        view.assign("thread_user_info", threadUserInfo);

        view.assign("thread_info", threadInfo);

        int page = request.input("page", "1").to!int;
        int limit = 10;
        auto postRepository = new PostRepository(_cManager);
        auto postDatas = postRepository.findAllByThreadId(id, page, limit);
        int uid = this.getUserId();
        
        auto post = postDatas.getContent();
        if(post.length == 0){
            return new NotFoundResponse();
        }
        view.assign("post", post);
        view.assign("threadid", id);
        view.assign("uid",uid); 
        view.assign("keywords", thread.keywords);
        view.assign("pageModel",  postDatas.getModel(5));
        view.assign("pageQuery", buildQueryString(request.input()));
        view.assign("paginateHtml",  view.render("paginate"));

        auto filesRepository = new AttachmentRepository(_cManager);
        auto attachments = filesRepository.findAllByPost(postDatas.getContent());
        view.assign("attachments", attachments);
        auto breadcrumbs = breadcrumbsManager.generate("forum.thread.thread", thread);
        view.assign("breadcrumbs", breadcrumbs);
        view.assign("title", breadcrumbsToTitle(breadcrumbs));

        view.assign("idx_star", (page-1)*limit + 1 );
        return new Response(request)
        .setHeader(HttpHeader.CONTENT_TYPE, MimeType.TEXT_HTML_UTF_8.asString())
        .setContent(view.render("forum/thread_thread"));
    }
    
    @Action string create(int forumId)
    {
        auto forumRepository = new ForumRepository(_cManager);
    
        if (request.methodAsString() == HttpMethod.POST.asString())
        {
            try{
                int threadId;
                if(forumId == 0)
                {
                    return "This forum is not exist";
                }
                auto forum = forumRepository.findUsableById(forumId);
                if (!forum)
                {
                    return "This forum is not exist";

                }
                string title = request.input("title", "");
                if (title.length == 0)
                {
                    return "The title can not be empty";

                }
                string keywords = request.input("keywords", "");
                if(keywords.length == 0)
                {
                    return "Please type in at least one keyword";

                }
                string markdown = request.input("content", "");
                if (markdown.length == 0)
                {
                    return "The content can not be empty";
                }

                if (markdown.length > 5120)
                {
                    return "The content length max 5120";
                }
                
                string replaceMarkdown = markdown;
                auto matchs = replaceMarkdown.matchAll(r"\[([^\]]+)\]\(attach:(\w+)\)");
                int[] usedAttachments;
                foreach(m; matchs)
                {
                    int attachmentId = m[2].to!int;
                    usedAttachments ~= attachmentId;
                    replaceMarkdown = replaceMarkdown.replace(m[0], "[" ~ m[1] ~ "](" ~ getAttachmentUrl(m[2].to!int) ~ ")");
                }

                import hunt.markdown.Extension;
                import hunt.markdown.node.Node;
                import hunt.markdown.parser.Parser;
                import hunt.markdown.renderer.html.HtmlRenderer;
                import hunt.markdown.ext.table;
                import hunt.collection.Collections;
                auto extensions = Collections.singleton(TableExtension.create());
                Parser parser = Parser.builder().extensions(extensions).build();
                Node document = parser.parse(replaceMarkdown);
                HtmlRenderer renderer = HtmlRenderer.builder().extensions(extensions).softbreak("<br />").build();
                string html = renderer.render(document);
                if(!html)
                {
                    throw new Exception("render error");
                }

                int curtime = cast(int)time();
                int uid = this.getUserId();
                
                auto thread = new Thread();
                thread.forum_id = forumId;
                thread.title = title;
                thread.uid = uid;
                thread.keywords = keywords;
                thread.posts = 1;
                thread.status = 1;
                thread.last_uid = uid;
                thread.last_time = curtime;
                thread.updated = curtime;
                thread.created = curtime;
                thread = (new ThreadRepository(_cManager)).insert(thread);
                threadId = thread.id;
                
                auto post = new Post();
                post.thread_id = thread.id;
                post.uid = this.getUserId();
                post.content = markdown;
                post.content_html = markdown;
            
                
                post.content_html = html;
                post.status = 1;
                post.created = curtime;
                auto postRepository = new PostRepository(_cManager);
                postRepository.insert(post);

                auto attachmentRepository = new AttachmentRepository(_cManager);
                
                auto attachmentRet = attachmentRepository.findPostAttachmentByUid(uid);
                int updateRet = 0;
                if(attachmentRet){
                    updateRet = attachmentRepository.updatePostAttachments(uid, post.id);
                }
                post.attachments = updateRet;
                postRepository.update(post);                
                attachmentRepository.updatePostAttachmentsUsed(usedAttachments);
                forum.threads += 1;
                forum.posts += 1;
                forum.lastThreadId = thread.id;
                forumRepository.save(forum);
                return threadId.to!string;
            }catch(Exception e){
                return e.msg;
            }
        }
            auto forums = forumRepository.findAllByUsable();
            view.assign("forums", forums);
            view.assign("forumId", forumId);
            auto breadcrumbs = breadcrumbsManager.generate("forum.thread.create");
            view.assign("breadcrumbs", breadcrumbs);
            view.assign("title", breadcrumbsToTitle(breadcrumbs));
            return view.render("forum/thread_create");
    }


    @Action string edit(int id)
    {
        int userId = this.getUserId();

        if(request.methodAsString() == HttpMethod.POST.asString())
        {
            try{   
                string postidstr = request.post("postid");
                int postid = request.post!int("postid");
                int forumid = request.post!int("forum_id");

                string markdown = request.input("content", "");

                string attachment_idinput = request.input("attachment_ids","");
                auto attachment_idsarr = split(attachment_idinput,",");

                string wcidstr = "-";
                
                foreach(wcid;attachment_idsarr){
                    wcidstr = wcidstr ~ ","~wcid.to!string;
                }
                wcidstr = wcidstr.replace("-,","");

                int curtime = cast(int)time();
                if (markdown.length == 0)
                {
                
                    return "The content can not be empty";
                }
                
                string replaceMarkdown = markdown;
                auto matchs = replaceMarkdown.matchAll(r"\[([^\]]+)\]\(attach:(\w+)\)");
                int[] usedAttachments;
                foreach(m; matchs)
                {
                    int attachmentId = m[2].to!int;
                    usedAttachments ~= attachmentId;
                    replaceMarkdown = replaceMarkdown.replace(m[0], "[" ~ m[1] ~ "](" ~ getAttachmentUrl(m[2].to!int) ~ ")");
                }
                  
                import hunt.markdown.Extension;
                import hunt.markdown.node.Node;
                import hunt.markdown.parser.Parser;
                import hunt.markdown.renderer.html.HtmlRenderer;
                import hunt.markdown.ext.table;
                import hunt.collection.Collections;
                auto extensions = Collections.singleton(TableExtension.create());
                Parser parser = Parser.builder().extensions(extensions).build();
                Node document = parser.parse(replaceMarkdown);
                HtmlRenderer renderer = HtmlRenderer.builder().extensions(extensions).softbreak("<br />").build();
                string html = renderer.render(document);
                auto postRepository = new PostRepository(_cManager);
                auto postitem = postRepository.find(postid);
                int threadId = postitem.thread_id;
                int uid = postitem.uid;
                string uidstr = uid.to!string;
                auto threadRepository = new ThreadRepository(_cManager);
                auto threadInfo = threadRepository.find(threadId);
                if(!threadInfo){
                    return "The thread can not found";
                }
                if(threadInfo.uid == userId){
                    auto forumRepository = new ForumRepository(_cManager);
                    auto forumInfo = forumRepository.find(forumid);
                    if(!forumInfo){
                        return "The forum can not found";

                    }
                    threadInfo.forum_id = forumid;
                    threadRepository.save(threadInfo);
                }
                postitem.content_html = html;
                postitem.updated = curtime;
                postitem.content = markdown;
                auto attachmentRepository = new AttachmentRepository(_cManager);
                auto attachments = attachmentRepository.findAllByItemId(postid);
                postitem.attachments =  (attachments.length).to!int;
                auto res = postRepository.save(postitem);
                if(attachment_idinput != "" && wcidstr !="-"){
                    attachmentRepository.updatePostAttachmentsBulk(postidstr,uidstr,wcidstr);
                }
                return threadId.to!string;
            }catch(Exception e){
                    return e.msg;
                }
        }    
        auto postRepository = new PostRepository(_cManager);
        auto  post = postRepository.findPostById(id);
        if(!post){
            return "post is not here";
        }
        if(post.uid != userId){
            return "You don't have the right to edit";
        }
        auto attachmentRepository = new AttachmentRepository(_cManager);
        auto attachments = attachmentRepository.findAllByItemId(id);
       

        int threadId = post.thread_id; 
        auto threadRepository = new ThreadRepository(_cManager);
        auto thread = threadRepository.findUsableById(threadId);
        auto forumRepository = new ForumRepository(_cManager);
        auto forums = forumRepository.findAllByUsable();
        view.assign("forums", forums);
        view.assign("forumId", thread.forum_id);
        if(thread.uid == userId){
            view.assign("owner", 1);
        }else{
            view.assign("owner", 0);
        }
        post.content = post.content.replace("'","\"");
        view.assign("post", post);
        view.assign("attachments", attachments);
        auto breadcrumbs = breadcrumbsManager.generate("forum.thread.thread", thread);
        view.assign("breadcrumbs", breadcrumbs);
        view.assign("title", breadcrumbsToTitle(breadcrumbs));
        return view.render("forum/thread_edit");
        
    }

    @Action
    Response reply(PostForm postForm)
    {
        try{
            auto data = request.all;
            int threadId;
            threadId = postForm.id;
            if (!threadId){
                return new RedirectResponse(request, url("forum.thread.reply"));
            }            
            auto threadRepository = new ThreadRepository(_cManager);
            auto thread = threadRepository.findUsableById(threadId);
            if (!thread){
                return new RedirectResponse(request, url("forum.thread.reply"));
            }
            string markdown = request.input("content", "");
            string replaceMarkdown = markdown;
        
            if (markdown == ""){
                return new RedirectResponse(request, url("forum.thread.reply"));
            }
            int uid = this.getUserId();

            auto attachmentRepository = new AttachmentRepository(_cManager);
            auto matchs = replaceMarkdown.matchAll(r"\[([^\]]+)\]\(attach:(\w+)\)");
            int[] usedAttachments;
            foreach(m; matchs)
            {
                int attachmentId = m[2].to!int;
                usedAttachments ~= attachmentId;
                replaceMarkdown = replaceMarkdown.replace(m[0], "[" ~ m[1] ~ "](" ~ getAttachmentUrl(m[2].to!int) ~ ")");
            }
            auto postRepository = new PostRepository(_cManager);
            int curtime = cast(int)time();
            import hunt.markdown.Extension;
            import hunt.markdown.node.Node;
            import hunt.markdown.parser.Parser;
            import hunt.markdown.renderer.html.HtmlRenderer;
            import hunt.markdown.ext.table;
            import hunt.collection.Collections;

            auto extensions = Collections.singleton(TableExtension.create());
            Parser parser = Parser.builder().extensions(extensions).build();
            Node document = parser.parse(replaceMarkdown);
            HtmlRenderer renderer = HtmlRenderer.builder().extensions(extensions).softbreak("<br />").build();
            string html = renderer.render(document);
           
            auto post = new Post();
            post.thread_id = threadId;
            post.uid = uid;
            post.content = markdown;
            post.content_html = html;
            post.status = 1;
            post.updated = curtime;
            post.created = curtime;
            postRepository.insert(post);
            
            auto attachmentRet = attachmentRepository.findPostAttachmentByUid(uid);
            if(attachmentRet){
                post.attachments = attachmentRepository.updatePostAttachments(post.uid, post.id);
            }else{
                post.attachments = 0;
            }
            postRepository.update(post);
            attachmentRepository.updatePostAttachmentsUsed(usedAttachments);
            thread.posts += 1;
            thread.last_uid = post.uid;
            thread.last_time = curtime;
            threadRepository.update(thread);
            string backurl = "http://"~request.host()~"/thread/" ~ threadId.to!string;//url("forum.thread.thread")；

            return new RedirectResponse(request, backurl);

        }catch(Exception e){
            return new Response(request)
            .setHeader(HttpHeader.CONTENT_TYPE, MimeType.TEXT_HTML_UTF_8.asString())
            .setContent(e.msg);
        }
        
    }

    @Action
    Response search(string k, int page)
    {
        int limit = 10;

        string keyWord = k;

        if(!keyWord){
                return new NotFoundResponse();  
        }

        if (page < 1)
        {
            page = 1;
        }
        
        auto threadRepository = new ThreadRepository(_cManager);
        
        auto threadsPage = threadRepository.selectListByWords(keyWord, page, limit);
        if(!threadsPage)
        {
            return new NotFoundResponse();
        }
        view.assign("words", keyWord);
        view.assign("threads", threadsPage.getContent());
        view.assign("pageModel", threadsPage.getModel());
        view.assign("pageQuery", buildQueryString(request.input()));
        view.assign("paginateHtml", view.render("paginate"));
        return new Response(request)
        .setHeader(HttpHeader.CONTENT_TYPE, MimeType.TEXT_HTML_UTF_8.asString())
        .setContent(view.render("forum/search"));
    }
}
