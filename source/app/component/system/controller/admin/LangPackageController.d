module app.component.system.controller.admin.LangPackageController;

import hunt.framework;
import hunt.framework.i18n.I18n;
import hunt.http.codec.http.model.HttpMethod;
import hunt.util.Serialize;
import hunt.util.DateTime;
import hunt.entity.domain;
import hunt.logging;
import app.component.system.model.LangPackage;
import app.component.system.repository.LangPackageRepository;
import app.component.system.repository.LanguageRepository;
import app.component.system.helper.Utils;
import app.component.system.controller.AdminBaseController;
import app.lib.Functions;
import std.algorithm;
import std.json;

class LangPackageController : AdminBaseController{
    
    mixin MakeController;
  
    this() {
        super();      
    }

    @Action 
    Response list(int perPage, int page = 1){
        perPage = perPage < 1 ? 10 : perPage;
        page = page < 1 ? 1 : page;
        auto alldata = (new LangPackageRepository()).findByLangPackage(page, perPage);
        view.assign("package", alldata.getContent());

        view.assign("pageModel",  alldata.getModel());
        view.assign("pageQuery", buildQueryString(request.input()));

        makePageBreadCrumbs("packageList");
        return ResponseView("system/package/list");
    }

    @Action 
    Response add() {
        makePageBreadCrumbs("packageAdd");
        auto repository = new LangPackageRepository();
        if (request.methodAsString() == HttpMethod.POST.asString()) {
            int now = cast(int) time();
            LangPackage lp = new LangPackage();

            lp.local = request.post("local", "");
            lp.value = request.post("value", "");
            if(lp.local == ""){
                return new Response(request)
                    .setHeader(HttpHeader.CONTENT_TYPE, MimeType.TEXT_HTML_UTF_8.asString())
                    .setContent("<script>alert('Must selected language!');history.back(-1);</script>");
            }

            int id = isNumeric(request.post("id", "0")) ? (request.post("id", "0")).to!int : 0;
            
            if(id > 0) {
                auto exsitData = repository.findById(id);
                if(exsitData !is null){
                    lp.created = exsitData.created;
                    lp.key = exsitData.key;
                    lp.id = id;
                }else{
                    return new Response(request)
                        .setHeader(HttpHeader.CONTENT_TYPE, MimeType.TEXT_HTML_UTF_8.asString())
                        .setContent("<script>alert('Can not find the data!');history.back(-1);</script>");
                }
            }else{
                lp.key = request.post("key", "");
                if(indexOf(lp.key, `__`) == 0){
                    int count = repository.findKey(lp.key);
                    if(count == 0){
                        return new Response(request)
                            .setHeader(HttpHeader.CONTENT_TYPE, MimeType.TEXT_HTML_UTF_8.asString())
                            .setContent("<script>alert('User cant defind header of a key with __');history.back(-1);</script>");
                    }
                }
                lp.created = now;
                int isAble = repository.isSet(lp.local, lp.key);
                if(isAble == 1){
                    return new Response(request)
                        .setHeader(HttpHeader.CONTENT_TYPE, MimeType.TEXT_HTML_UTF_8.asString())
                        .setContent("<script>alert('The key already exist！');history.back(-1);</script>");
                }
            }
            lp.updated = now;

            auto saveRes = repository.save(lp);
            if (saveRes !is null){
                I18n i18n = I18n.instance();
                i18n.add(lp.local, lp.key, lp.value);
                return new RedirectResponse(request, url("system.langpackage.list", null, "admin"));
            }
        }

        auto languageRepository = new LanguageRepository();
        view.assign("languages", languageRepository.findAll());

        return ResponseView("system/package/add");
    }

    @Action 
    Response edit(int id) {
        makePageBreadCrumbs("packageEdit");
        auto repository = new LangPackageRepository();
        auto languageRepository = new LanguageRepository();
        view.assign("languages", languageRepository.findAll());
        view.assign("languageWord", repository.find(id));
        return ResponseView("system/package/edit");
    }

    @Action Response del(int id) {
        (new LangPackageRepository()).removeById(id);
        return new RedirectResponse(request, url("system.langpackage.list", null, "admin"));
    }
}
