module app.component.system.controller.admin.SettingController;

import app.component.system.controller.AdminBaseController;
import app.lib.Functions;
import hunt.framework;
import hunt.logging;
import app.component.system.model.Setting;
import app.component.system.repository.SettingRepository;


class SettingController : AdminBaseController {

    mixin MakeController;

    this() {
        super();  
    }
    
    @Action 
    Response add() {
        if(request.methodAsString() == HttpMethod.POST.asString())
        {
            string option = request.post("option");
            if(!option){
                    assignError("Option is not validated.");
            }
            string val = request.post("val");
            if(!val){
                assignError("Value is not validated.");
            }
            string explain = request.post("explain");
            if(!explain){
                assignError("Explain is not validated.");
            }
            auto setting = new Setting();
            int curtime = cast(int)time();
            setting.key = option;
            setting.value = val;
            setting.explain = explain;
            setting.created = curtime;
            setting.updated = curtime;

            auto settingRepository = new SettingRepository();
            auto ret = settingRepository.insert(setting);
            return new RedirectResponse(request, url("system.setting.list", null, "admin"));
        }  
        string lang = findLocal();
 
        return new Response(request)
            .setHeader(HttpHeader.CONTENT_TYPE, MimeType.TEXT_HTML_UTF_8.asString())
            .setContent(view.setLocale(lang).render("system/setting/add"));
           
    }

    @Action 
    Response edit() {
        int id = request.get!int("id", 0);
        auto settingRepository = new SettingRepository();
        auto settingItem = settingRepository.findById(id);
        if(!settingItem){
                assignError("Parameter is not validated.");
        }
        if(request.methodAsString() == HttpMethod.POST.asString())
        {
            int updated = cast(int)time();
            string explain = request.post("explain");
            string option = request.post("option");
            string value = request.post("val");
            settingItem.explain = explain;
            settingItem.key = option;
            settingItem.value = value;
            settingItem.id = id;
            settingItem.updated = updated;
            auto ret = settingRepository.save(settingItem);
            string lang = findLocal();
            return new RedirectResponse(request, url("system.setting.list", null, "admin"));
       
        }
        view.assign("setting", settingItem);

        string lang = findLocal();
        return new Response(request)
            .setHeader(HttpHeader.CONTENT_TYPE, MimeType.TEXT_HTML_UTF_8.asString())
            .setContent(view.setLocale(lang).render("system/setting/edit"));

          
    }

    @Action 
    Response list(int perPage, int page = 1) { 
        auto settingRepository = new SettingRepository();
        perPage = perPage < 1 ? 10 : perPage;
        auto alldata = settingRepository.getList(page-1, perPage);
        view.assign("list", alldata.getContent());
        view.assign("pageModel",  alldata.getModel());
        view.assign("pageQuery", buildQueryString(request.input()));
        return new Response(request)
            .setHeader(HttpHeader.CONTENT_TYPE, MimeType.TEXT_HTML_UTF_8.asString())
            .setContent(view.render("system/setting/list"));    
    }

    @Action 
    Response del() {
        int id = request.get!int("id", 0);

        auto settingRepository = new SettingRepository();
        auto settingItem = settingRepository.findById(id);
        if(!settingItem){
                assignError("Parameter is not validated.");
        }    
        int updated = cast(int)time();
        settingItem.id = id;
        settingItem.deleted = 1;
        settingItem.updated = updated;
        auto ret = settingRepository.save(settingItem);
        return new RedirectResponse(request, url("system.setting.list", null, "admin")); 
          
    }



}
