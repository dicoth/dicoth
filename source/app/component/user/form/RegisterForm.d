module app.component.user.form.RegisterForm;

import hunt.framework;

class RegisterForm : Form
{
    mixin MakeForm;

    @Length(4, 30, "username length must be {{min}} and {{max}}")
    string username;

    @Length(8, 32, "password length must be {{min}} and {{max}}")
    string password;

    string rpassword;

    @NotEmpty("nickname not null")
    string nickname;

    @NotEmpty("captcha not null")
    string captcha;
}