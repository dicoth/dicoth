module app.component.system.model.User;

import hunt.entity;
import std.conv;

public import app.component.system.model.UserRole;

@Table("system_user")
class User : Model {

    mixin MakeModel;

    @AutoIncrement
    @PrimaryKey
    int id;

//    int role_id;
//    @OneToMany("user")
//    UserRole[] userRoles;

    string email;

    string password;

    string salt;

    // @Column("post_title")
    string name;

    string avatar;

    // timestamp
    int created;

    // timestamp
    int updated;

    // 1: enabled, 0: disabled
    short status;

    short supered;

    string language;

    override string toString() {
        return "id: " ~ id.to!string ~ "email: " ~ email ~ ", name: " ~ name;
    }

    override size_t toHash() const @safe pure nothrow {
        return id; // hashOf(email) + hashOf(created);
    }
}
