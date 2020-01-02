module app.component.system.Form.UserForm;

import hunt.framework;

class UserForm : Form {

	mixin MakeForm;

	@Email  
	string username;

	@Length(4,12)
    string name;

	@Range(0,2)
	short status;
	
}