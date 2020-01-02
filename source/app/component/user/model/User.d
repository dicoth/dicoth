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
