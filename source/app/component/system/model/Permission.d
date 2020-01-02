module app.component.system.model.Permission;

import hunt.entity;

@Table("system_permission")
class Permission : Model 
{
    mixin MakeModel;

    @PrimaryKey
    int id;

    string mca;

    string title;

    int group_id;

    @Column("is_action")
    short isAction;

    // timestamp
    int created;

    // timestamp
    int updated;

    // 1: enabled, 0: disabled
    short status;
}
