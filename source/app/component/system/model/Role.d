module app.component.system.model.Role;

import hunt.entity;

@Table("system_role")
class Role : Model 
{
    mixin MakeModel;

    @AutoIncrement
    @PrimaryKey
    int id;

    // @OneToMany("role")
    // UserRole[] userRoles;

    string name;

    // timestamp
    int created;

    // timestamp
    int updated;

    // 1: enabled, 0: disabled
    short status;

}
