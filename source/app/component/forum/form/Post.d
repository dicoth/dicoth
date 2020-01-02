module app.component.forum.form.Post;

import hunt.framework;


class PostForm : Form
{
    mixin MakeForm;

    @Min(1,"Lack of forum id")
    int id;

    @Length(1, 500, "The content must between 1 and 500 words")
    string content;
}