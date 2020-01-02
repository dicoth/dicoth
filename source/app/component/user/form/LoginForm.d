module app.component.user.form.LoginForm;

import hunt.framework;

class LoginForm : Form
{
    mixin MakeForm;

    @Length(6, 30, "username or password validation failed")
    string username;

    @Length(8, 32, "username or password validation failed")
    string password;

    short remember_me;
}