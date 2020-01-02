module app.component.forum.model.Thread;

import hunt.entity;
import app.component.forum.model.Forum;
import app.component.user.model.User;

@Table("forum_thread")
class Thread : Model
{
    mixin MakeModel;

    @AutoIncrement
    @PrimaryKey
    int id;

    int forum_id;
    @JoinColumn("forum_id")
    Forum forum;

    string title;

    int uid;
    @JoinColumn("uid")
    User user;

    string keywords;

    int posts;

    int views;

    short status;

    int last_uid;
    @JoinColumn("last_uid")
    User last_user;

    int last_time;

    int deleted;

    int created;

    int updated;
}