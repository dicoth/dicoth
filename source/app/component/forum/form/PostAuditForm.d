module app.component.forum.form.PostAuditForm;

import hunt.framework;


class PostAuditForm : Form
{
    mixin MakeForm;

    @Min(1,"Lack of this id")
    int id;

    @Range(1, 3, "No extra options")
    int audit;
}