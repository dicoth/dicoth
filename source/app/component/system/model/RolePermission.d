module app.component.system.model.RolePermission;

import hunt.entity;

@Table("system_role_permission")
class RolePermission : Model 
{
    mixin MakeModel;

    @AutoIncrement
    @PrimaryKey
    int id;

    int role_id;

    int permission_id;

    string permission_mca;
  
}
