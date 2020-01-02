module app.component.attachment.model.Attachment;

import hunt.entity;

import app.component.user.model.User;

@Table("attachment")
class Attachment : Model
{
    mixin MakeModel;

    @AutoIncrement
    @PrimaryKey
    int id;

    string type;

    int item_id;

    short is_used;

    int uid;
    @JoinColumn("uid")
    User user;

    string original_name;

    string filename;

    string extension;

    string mime;

    long size;

    int downloads;

    int created;

    int deleted;

    int audited;

    short status;

    
}
