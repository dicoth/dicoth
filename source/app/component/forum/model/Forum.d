module app.component.forum.model.Forum;

import hunt.entity;

@Table("forum")
class Forum : Model
{
    mixin MakeModel;

    @AutoIncrement
    @PrimaryKey
    int id;

    string name;

    string description;

    string icon;

    @Column("type_id")
    int typeId;

    int pid;

    int threads;

    int posts;

    short status;

    @Column("last_thread_id")
    int lastThreadId;

    int created;

    int updated;

    int deleted;
}
