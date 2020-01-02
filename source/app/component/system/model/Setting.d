module app.component.system.model.Setting;

import hunt.entity;

@Table("system_setting")
class Setting : Model
{
    mixin MakeModel;

    // @OneToMany("role")
    // UserRole[] userRoles;
    @PrimaryKey
    @AutoIncrement
    int id;

    string key;


    // 1: enabled, 0: disabled
    string value;

    int created;

    int updated;

    int deleted;


    string explain;

}

struct SettingItem
{
    string key;
}

class SettingObject
{
    @SettingItem("site_name")
    string siteName = "Putao Technology";

    @SettingItem("site_url")
    string siteUrl = "https://localhost/";

    @SettingItem("site_keyworkds")
    string siteKeywords = "Putao Technology";

    @SettingItem("site_description")
    string siteDescription = "A huntcms based website.";

    @SettingItem("site_author")
    string siteAuthor = "Putao Technology";
    // @SettingItem("site_status")
    // bool siteStatus = true;
}
