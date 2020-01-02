module app.component.user.form.UserinfoForm;

import hunt.framework;

class UserinfoForm : Form
{
    mixin MakeForm;

    @Length(1, 20,"nickname length 1 ~ 20 !")
    string nickname;

    @NotEmpty("email not empty!")
    string email;

    @NotEmpty("introduce not empty!")
    string introduce;

    @NotEmpty("avatar not empty!")
    string avatar;
}