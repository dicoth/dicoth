module app.providers.DicothBreadcrumbServiceProvider;


import hunt.framework.provider.ServiceProvider;
import hunt.framework.provider.BreadcrumbServiceProvider;
import hunt.framework.application;
import hunt.framework.Simplify;

import hunt.logging.ConsoleLogger;

import std.conv;

/**
 * 
 */
class DicothBreadcrumbServiceProvider : BreadcrumbServiceProvider {

    override void boot() {

        breadcrumbs.register("forum.forum.list", (Breadcrumbs trail, Object[] params...) {
            trail.push("Home", url("forum.forum.list"));
        });

        breadcrumbs.register("forum.forum.forum", (Breadcrumbs trail, Object[] params...) {
            import app.component.forum.model.Forum;
            trail.parent("forum.forum.list");
            if(params)
            {
                Forum forum = cast(Forum)params[0];
                trail.push(forum.name, url("forum.forum.forum", ["id": forum.id.to!string]));
            }else{
                trail.push("Threads list", url("forum.forum.forum"));
            }
        });

        breadcrumbs.register("forum.thread.thread", (Breadcrumbs trail, Object[] params...) {
            import app.component.forum.model.Thread;
            Thread thread = cast(Thread)params[0];
            trail.parent("forum.forum.forum", thread.forum);
            trail.push(thread.title, url("forum.thread.thread"));
        });

        breadcrumbs.register("forum.thread.create", (Breadcrumbs trail, Object[] params...) {
            trail.parent("forum.forum.list");
            trail.push("Publish Thread", url("forum.thread.create"));
        });

        breadcrumbs.register("user.user.profile", (Breadcrumbs trail, Object[] params...) {
            trail.parent("forum.forum.list");
            string title = "User Profile";
            if(params)
            {
                import app.component.user.model.User;
                auto user = cast(User)params[0];

                title = user.nickname ~ "'s Profile";
            }

            trail.push(title, url("user.user.profile"));
        });

        // string s = breadcrumbs.render("index.show", null) ;
        // trace(s);
    }
}