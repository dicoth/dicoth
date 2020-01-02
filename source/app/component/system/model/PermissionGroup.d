module app.component.system.model.PermissionGroup;

import hunt.entity;

@Table("system_permission_group")
class PermissionGroup : Model 
{
    mixin MakeModel;

    @PrimaryKey
    int id;

    string title;
    
    string sign;

    int sort;

    // 1: enabled, 0: disabled
    short status;

    // timestamp
    int created;

    // timestamp
    int updated;

}
