module app.component.forum.controller.admin.ForumController;

import hunt.framework;

import app.component.system.controller.AdminBaseController;
import app.lib.Functions;

import app.component.forum.repository.ForumRepository;
import app.component.forum.model.Forum;
import app.component.forum.form.ForumForm;
import app.component.system.helper.Utils;


class  ForumController  : AdminBaseController
{
    mixin MakeController;

    this()
    {
        super();      
    }

    @Action Response list(int perPage, int page = 1, string k = "")
    {

        perPage = perPage < 1 ? 10 : perPage;
        string keyWord = k;
        auto alldata = (new ForumRepository(_cManager)).findByForum(keyWord, page-1, perPage);

        view.assign("forums", alldata.getContent());
        view.assign("pageModel",  alldata.getModel());
        view.assign("pageQuery", buildQueryString(request.input()));

        return new Response(request)
        .setHeader(HttpHeader.CONTENT_TYPE, MimeType.TEXT_HTML_UTF_8.asString())
        .setContent(view.render("forum/admin/list"));
    }

    @Action Response add(ForumForm form, int pid)
    {
        auto forumrepository = new ForumRepository(_cManager);
        auto forum = new Forum;
        if(request.method == HttpMethod.POST)
        {
            auto result = form.valid();
            if(!result.isValid){
                auto errors = result.messages();
                foreach(error; errors){
                    this.assignError(error);
                }
                return new RedirectResponse(request, url("admin:forum.forum.list"));
            }

            auto now = cast(int) time();
            forum.name = form.name;
            forum.description = form.description;
            forum.icon = form.icon;
            forum.pid = form.pid;
            forum.typeId = form.typeId;
            forum.created = now;
            forum.updated = now;
            forumrepository.save(forum);
            return new RedirectResponse(request, url("admin:forum.forum.list"));
        }
        view.assign("firstLevelForums", forumrepository.findAll());

        auto groupForums = forumrepository.getGroupForums();
        auto forums = toForumList(0, groupForums, 0);
        view.assign("groupForums", forums);

        return new Response(request)
            .setHeader(HttpHeader.CONTENT_TYPE, MimeType.TEXT_HTML_UTF_8.asString())
            .setContent(view.render("forum/admin/add"));

    }

    struct ForumItem
    {

        Forum forum;
        int level;
        string prefix;

    }

    ForumItem[] toForumList(int currentId, Forum[][int] groupForums, int currentLevel)
    {

        ForumItem[] nodes;
        foreach (forum; groupForums[currentId])
        {

            if(forum.deleted > 0)
            {
                continue;
            }

            ForumItem node;
            node.forum = forum;
            node.level = currentLevel;

            string prefix;
            foreach (i; 0..currentLevel)
            {
                prefix ~= "--";
            }
            node.prefix = prefix;

            nodes ~= node;

            if (forum.id in groupForums)
            {
                nodes ~= toForumList(forum.id, groupForums, currentLevel + 1);
            }

        }
        return nodes;
    }
    
    @Action Response edit(ForumForm form)
    {
        auto forumrepository = new ForumRepository(_cManager);
        auto forum = new Forum;
        if(request.method == HttpMethod.POST)
        {
            auto result = form.valid();
            if(!result.isValid){
                auto errors = result.messages();
                foreach(error; errors){
                    this.assignError(error);
                }
                return new RedirectResponse(request, url("admin:forum.forum.list"));
            }

        int now = cast(int) time();
        int postId = initInt("id", 0, "POST");
        if(postId > 0)
        {
            forum = forumrepository.find(postId);
            forum.name = form.name;
            forum.description = form.description;
            forum.icon = form.icon;
            forum.pid = form.pid;
            forum.typeId = form.typeId;
            forum.created = now;
            forum.updated = now;


            forumrepository.save(forum);
            return new RedirectResponse(request, url("admin:forum.forum.list"));
        }
        else
        {
            this.assignError("Edit error");
            return new Response(request)
                .setHeader(HttpHeader.CONTENT_TYPE, MimeType.TEXT_HTML_UTF_8.asString())
                .setContent("<script>alert('Must selected language!');history.back(-1);</script>");
        }

        }

        int id = initInt("id", 0, "GET");
        if(id > 0)
        {
            forum = forumrepository.find(id);
        }
        else
        {
            this.assignError("Parameter error");
            return new Response(request)
                .setHeader(HttpHeader.CONTENT_TYPE, MimeType.TEXT_HTML_UTF_8.asString())
                .setContent("<script>alert('Must selected language!');history.back(-1);</script>");
        }

        view.assign("forum", forum);
        view.assign("firstLevelForums", forumrepository.findAll());

        auto groupForums = forumrepository.getGroupForums();
        auto forums = toForumList(0, groupForums, 0);
        view.assign("groupForums", forums);

        return new Response(request)
            .setHeader(HttpHeader.CONTENT_TYPE, MimeType.TEXT_HTML_UTF_8.asString())
            .setContent(view.render("forum/admin/edit"));
    }

    @Action Response del(int id)
    {
        auto count = (new ForumRepository(_cManager)).DelForum(id);
        if(count == 0)
        {
            auto now = cast(int) time();
            auto det = (new ForumRepository(_cManager)).DelByForum(id, now);
            this.assignSussess("Deleted successfully！");
        }
        else
        {
            this.assignError("Please delete its children first");
        }
        return new RedirectResponse(request, url("admin:forum.forum.list"));
    }



    

} 