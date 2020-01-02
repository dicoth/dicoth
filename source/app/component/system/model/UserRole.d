module app.component.system.model.UserRole;

import hunt.entity;

public import app.component.system.model.User;

@Table("system_user_role")
class UserRole : Model 
{
    mixin MakeModel;

    @AutoIncrement
    @PrimaryKey
    int id;

    int user_id;

    int role_id;

    // int role_id;
    // @ManyToOne()
    // @JoinColumn("role_id")
    // Role role;

//    @ManyToOne()
//    @JoinColumn("user_id")
//    User user;

    // int user_id;

}
