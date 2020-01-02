module app.component.system.model.Language;

import hunt.entity;

@Table("system_language")
class Language : Model 
{
    mixin MakeModel;

    @AutoIncrement
    @PrimaryKey
    int id;

    string title;

    string sign;

    short status;

}
