module app.component.system.model.Menu;

import hunt.entity;

@Table("system_menu")
class Menu : Model 
{
    mixin MakeModel;

    @AutoIncrement
    @PrimaryKey
    int id;

    int pid;

    string name;

    @Column("is_action")
    short isAction;

    // mca is Module + Controller + Action
    // example: system.user.add
    string mca;
    
    string keyword;

    @Column("link_url")
    string linkUrl;

    @Column("icon_class")
    string iconClass;

    int sort;
    
    // timestamp
    int created;

    // timestamp
    int updated;

    // 1: enabled, 0: disabled
    short status;
}
