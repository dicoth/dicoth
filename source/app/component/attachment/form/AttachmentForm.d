module app.component.attachment.form.AttachmentForm;

import hunt.framework;


class AttachmentForm : Form
{
    mixin MakeForm;

    @Min(1,"Not found this id")
    int id;

    @Range(1, 3, "Out of range")
    int audit;
}