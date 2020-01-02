module app.component.user.model.UserOauth;
import hunt.entity;

@Table("user_oauth")
class UserOauth : Model
{
    mixin MakeModel;

    @AutoIncrement
    @PrimaryKey
    int    id;
    int uid;
    string oauth_token;
    int flag;
    int updated;

    int created;
}
