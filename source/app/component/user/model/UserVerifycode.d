module app.component.user.model.UserVerifycode;
import hunt.entity;

@Table("user_verifycode")
class UserVerifycode : Model
{
    mixin MakeModel;

    @AutoIncrement
    @PrimaryKey
    int    id;
    int code_type;
    string account;
    string code;
    int updated;

    int created;
    int status ;
}