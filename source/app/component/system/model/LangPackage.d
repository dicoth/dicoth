module app.component.system.model.LangPackage;

import hunt.entity;

@Table("system_lang_package")
class LangPackage : Model {

    mixin MakeModel;

    @AutoIncrement
    @PrimaryKey
    int id;

    string local;

    string key;

    string value;

    int created;

    int updated;

}
