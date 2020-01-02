module app.component.system.form.LoginForm;

import hunt.framework;

class LoginForm : Form {

	mixin MakeForm;

	@Email  
	string username;

	@Length(4,16)
    string password;

}