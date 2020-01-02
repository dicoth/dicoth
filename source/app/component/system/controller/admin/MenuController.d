module app.component.system.controller.admin.MenuController;

import app.component.system.helper.Utils;
import app.component.system.model.LangPackage;
import app.component.system.model.Menu;
import app.component.system.repository.LangPackageRepository;
import app.component.system.repository.MenuRepository;
import app.component.system.validation.MenuForm;
import app.component.system.controller.AdminBaseController;
import app.lib.Functions;

import hunt.entity.domain;
import hunt.framework;
import hunt.framework.application.ApplicationConfig;
import hunt.framework.i18n.I18n;
import hunt.logging;
import hunt.http.codec.http.model.HttpMethod;
import hunt.util.Configuration;
import hunt.util.DateTime;
import hunt.util.Serialize;
import std.uni;
import std.json;

class MenuController : AdminBaseController {

    mixin MakeController;
    
    this(){
        super();      
    }

    @Action 
    Response list(int page, int perPage = 1) {
        page = page < 1 ? 1 : page;
        perPage = perPage < 1 ? 10 : perPage;
        auto alldata = (new MenuRepository()).findByMenu(page, perPage);

        view.assign("menus", alldata.getContent());
        view.assign("pageModel",  alldata.getModel());
        view.assign("pageQuery", buildQueryString(request.input()));
        makePageBreadCrumbs("menuList");
        return ResponseView("system/menu/list");
    }

    @Action 
    Response add(MenuForm menuForm) {

        MenuRepository menuRepository = new MenuRepository();
        int errorNum = 0;

        string lang = findLocal();
        if (request.methodAsString() == HttpMethod.POST.asString()) {
            int now = cast(int) time();

            auto validRes = menuForm.valid();
            if(!validRes.isValid()) {
                auto errors = validRes.messages();
                foreach(error; errors) {
                    errorNum += 1;
                    assignError(error);
                }      
                return new RedirectResponse(request, url("admin:system.menu.add"));
            }

            Menu menu = new Menu();
            menu.pid = menuForm.pid;
            menu.name = menuForm.name;
            menu.mca = menuForm.mca;
            menu.linkUrl = menuForm.linkUrl;
            menu.iconClass = menuForm.iconClass;
            menu.sort = menuForm.sort;
            menu.isAction = menuForm.actionRadio;
            menu.status = menuForm.statusRadio;
            menu.created = now;
            menu.updated = now;

            auto saveRes = menuRepository.save(menu);
            if (saveRes !is null){
                auto keyWord = "__SYSTEM_MENU_" ~ (saveRes.id).to!string;
                if(saveRes.keyword != keyWord){
                    saveRes.keyword = keyWord;
                    menuRepository.save(saveRes);
                }
                autoUpdateLanguage(keyWord, menuForm.name);
            }
            return new RedirectResponse(request, url("admin:system.menu.list"));
        }

        view.assign("firstLevelMenus", menuRepository.getMenusByPid(0));
        makePageBreadCrumbs("menuAdd");

        return ResponseView("system/menu/add", lang);
    }

    @Action 
    Response edit(MenuForm menuForm) {
        MenuRepository menuRepository = new MenuRepository();
        Menu menu = new Menu();
        int id, errorNum = 0;

        if(request.methodAsString() == HttpMethod.POST.asString()) {
            
            id = initNum("id", 0, "POST");
            view.assign("id", id);

            if (id > 0) {
                menu = menuRepository.find(id);
                if (menu is null){
                    errorNum += 1;
                    assignError("Data error or does not exist, please try again later");
                }
            } else {
                errorNum += 1;
                assignError("Parameter ID cannot be empty!");
            }
            if (errorNum > 0) {
                return new RedirectResponse(request, url("admin:system.menu.list"));
            }

            auto validRes = menuForm.valid();
            if(!validRes.isValid()) {
                auto errors = validRes.messages();
                foreach(error; errors) {
                    assignError(error);
                }                
                string[string] params;
                params["id"] = id.to!string;
                return new RedirectResponse(request, url("system.menu.list", params, "admin"));
            }

            int now = cast(int) time();
            menu.pid = menuForm.pid;
            menu.name = menuForm.name;
            menu.mca = menuForm.mca;
            menu.linkUrl = menuForm.linkUrl;
            menu.iconClass = menuForm.iconClass;
            menu.sort = menuForm.sort;
            menu.isAction = menuForm.actionRadio;
            menu.status = menuForm.statusRadio;
            menu.updated = now;

            auto saveRes = menuRepository.save(menu);

            if (saveRes !is null){
                auto keyWord = "__SYSTEM_MENU_" ~ (saveRes.id).to!string;
                autoUpdateLanguage(keyWord, menuForm.name);
            }

            assignSussess("Data modification succeeded!");
            return new RedirectResponse(request, url("admin:system.menu.list"));
        }

        id = initNum("id", 0, "GET");
        if (id > 0) {
            menu = menuRepository.find(id);
            if (menu is null){
                errorNum += 1;
                assignError("Data error or does not exist, please try again later");
            }
        } else {
            errorNum += 1;
            assignError("Parameter ID cannot be empty!");
        }
        if (errorNum > 0) {
            return new RedirectResponse(request, url("admin:system.menu.list"));
        }

        view.assign("menu", menu);
        view.assign("firstLevelMenus", menuRepository.getMenusByPid(0));
        makePageBreadCrumbs("menuEdit");
        
        return ResponseView("system/menu/edit");
    }

    @Action 
    Response del(int id) {
        (new MenuRepository()).removeById(id);
        return new RedirectResponse(request, url("admin:system.menu.list"));
    }

    bool autoUpdateLanguage(string keyword, string showname, string language = "") {
        int now = cast(int) time();
        if (language == "") language = findLocal();
        auto repository = new LangPackageRepository();
        LangPackage lpn;
        lpn = repository.findByKeyword(language, keyword);
        if(lpn !is null){
            if(lpn.value != showname){
                lpn.value = showname;
                lpn.updated = now;
                repository.save(lpn);
                I18n i18n = I18n.instance();
                i18n.add(lpn.local, keyword, lpn.value);
            }
        }else{
            lpn = new LangPackage();
            lpn.local = language;
            lpn.value = showname;
            lpn.key = keyword;
            lpn.created = now;
            lpn.updated = now;
            repository.save(lpn);
            I18n i18n = I18n.instance();
            i18n.add(lpn.local, lpn.key, lpn.value);
        }
        return true;
    }
}
