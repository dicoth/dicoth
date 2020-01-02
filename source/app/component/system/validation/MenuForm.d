module app.component.system.validation.MenuForm;

import hunt.framework;

class MenuForm : Form {

	mixin MakeForm;

    @Range(0, 2147483646)
    int pid;

	@Length(1,255)
    string name;

	@Range(0,2)
	short actionRadio;

	@Length(0,64)
    string mca;

	// @Length(1,255)
    // string keyword;

	@Length(1,255)
    string linkUrl;

	@Length(0, 255)
    string iconClass;

    @Range(0, 2147483646)
    int sort;

	@Range(0,2)
	short statusRadio;

}

