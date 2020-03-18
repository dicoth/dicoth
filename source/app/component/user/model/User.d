module app.component.user.model.User;
import hunt.entity;

@Table("user")
class User : Model
{
    mixin MakeModel;

    @AutoIncrement
    @PrimaryKey
    int    id;

    @Column("uas_unid")
    string unid;

    @Column("uas_openid")
    string openid;

    string mobile;

    string email;

    string username;

    string password;

    string salt;

    short status;

    string nickname;

    string avatar;

    short gender;

    string introduce;

    int updated;

    string ip;

    int created;

    override string toString() {
        return username;
    }

    // FIXME: Needing refactor or cleanup -@zhangxueping at 2020-03-18T19:31:43+08:00
    // Which leads an error in /views/default/forum/forum_list.html
    // override size_t toHash() const @safe pure nothrow {
    //     return hashOf(username) + hashOf(created);
    // }
}

class UserSession
{
    int uid;
    string nickname;
    string email;
    string avatar;
    string mobile;
    int time;
    string date;
}
