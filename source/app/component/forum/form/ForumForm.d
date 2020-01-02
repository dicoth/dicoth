module app.component.forum.form.ForumForm;

import hunt.framework;

class ForumForm : Form
{
    mixin MakeForm;

    @Length(1, 20, "Length of name must be between {{ min }} and {{ max }} !")
    string name;


    @Length(1, 200, "Length of description must be between {{ min }} and {{ max }} !")
    string description;

    // @NotEmpty("NOT NULL")
    @Length(0, 200, "Length of description must be between {{ min }} and {{ max }} !")
    string icon;

    @Min(0)
    int pid;

    @Min(1)
    @Max(3)
    int typeId;
}