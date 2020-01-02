module app.component.system.controller.admin.PermissionGroupController;

import app.component.system.helper.Paginate;
import app.component.system.helper.Utils;
import app.component.system.model.PermissionGroup;
import app.component.system.repository.PermissionGroupRepository;
import app.component.system.controller.AdminBaseController;
import app.lib.Functions;

import hunt.entity.domain;
import hunt.framework;
import hunt.http.codec.http.model.HttpMethod;
import hunt.logging;
import hunt.util.DateTime;
import hunt.util.Serialize;

class PermissionGroupController : AdminBaseController {

    mixin MakeController;

    this() {
        super();   
    }

    @Action 
    Response list(int perPage, int page = 1) {
        perPage = perPage < 1 ? 10 : perPage;
        auto alldata = (new PermissionGroupRepository()).findByPermissionGroup(page-1, perPage);
        view.assign("groups", alldata.getContent());

        view.assign("pageModel",  alldata.getModel());
        view.assign("pageQuery", buildQueryString(request.input()));

        makePageBreadCrumbs("permissionGroupList");
        return ResponseView("system/permissiongroup/list");
    }

    @Action Response add(){

        makePageBreadCrumbs("permissionGroupList");
        if (request.methodAsString() == HttpMethod.POST.asString()){
            int now = cast(int) time();
            auto pr = new PermissionGroupRepository();
            PermissionGroup pm = new PermissionGroup;
            pm.sign = request.post("sign");
            pm.title = request.post("title");
            pm.sort = request.post("sort").to!int;
            pm.status = request.post("statusRadio").to!short;
            if(request.post("id")){
                auto exsit_data = pr.findById(request.post("id").to!int);
                if(exsit_data !is null){
                    pm.created = exsit_data.created;
                }
            }else{
                pm.created = now;
            }
            pm.updated = now;

            auto saveRes = pr.save(pm);
            if (saveRes !is null)
                return new RedirectResponse(request, url("system.permissiongroup.list", null, "admin"));
        }
        return ResponseView("system/permissiongroup/add");
    }


    @Action 
    Response edit(int id) {
        makePageBreadCrumbs("permissionGroupList");
        auto repository = new PermissionGroupRepository();
        view.assign("group", repository.find(request.get("id").to!int));
        return ResponseView("system/permissiongroup/edit");
    }

    @Action 
    Response del(int id) {

        (new PermissionGroupRepository()).removeById(request.get("id").to!int);
        return new RedirectResponse(request, url("system.permissiongroup.list", null, "admin"));
        
    }
}
