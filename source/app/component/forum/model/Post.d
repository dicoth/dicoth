module app.component.forum.model.Post;

import hunt.entity;
import app.component.user.model.User;
import app.component.forum.model.Forum;
import app.component.forum.model.Thread;

@Table("forum_post")
class Post : Model
{
     mixin MakeModel;

    @AutoIncrement
    @PrimaryKey
    int id;

    int thread_id;
    @JoinColumn("Thread_id")
    Thread thread;

    int uid;
    @JoinColumn("uid")
    User user;

    string content;

    string content_html;

    int likes;

    int comments;

    short status;

    int attachments;

    int deleted;

    int created;

    int updated;

    int audited;
}