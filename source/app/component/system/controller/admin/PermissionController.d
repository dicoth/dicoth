module app.component.system.controller.admin.PermissionController;

import app.component.system.helper.Paginate;
import app.component.system.helper.Utils;
import app.component.system.model.Permission;
import app.component.system.model.PermissionGroup;
import app.component.system.repository.PermissionRepository;
import app.component.system.repository.PermissionGroupRepository;
import app.component.system.controller.AdminBaseController;
import app.lib.Functions;

import hunt.entity.domain;
import hunt.framework;
import hunt.http.codec.http.model.HttpMethod;
import hunt.logging;
import hunt.util.Serialize;
import hunt.util.DateTime;

class PermissionController : AdminBaseController {

    mixin MakeController;

    this() {
        super();   
    }

    @Action 
    Response list(int perPage, int page = 1) {
        perPage = perPage < 1 ? 10 : perPage;
        string k = request.get!string("k");
        int s = request.get!int("s", -1);
        auto alldata = (new PermissionRepository()).findByPermission(k, s, page -1, perPage);
        auto data = (new PermissionGroupRepository()).findByPermissionGroup(page, perPage);
        view.assign("permissions", alldata.getContent());
        view.assign("groups", data.getContent());

        view.assign("pageModel",  alldata.getModel());
        view.assign("pageQuery", buildQueryString(request.input()));
 
        makePageBreadCrumbs("permissionList");
        return ResponseView("system/permission/list");
    }

    @Action 
    Response add() {

        makePageBreadCrumbs("permissionAdd");
        if (request.methodAsString() == HttpMethod.POST.asString())
        {
            int now = cast(int) time();
            auto pr = new PermissionRepository();
            Permission pm = new Permission;
            pm.mca = request.post("mca");
            pm.title = request.post("title");
            pm.group_id = request.post("groupId").to!int;
            pm.isAction = request.post("actionRadio").to!short;
            pm.status = request.post("statusRadio").to!short;
            if(request.post("id"))
            {
                auto exsit_data = pr.findById(request.post("id").to!int);
                if(exsit_data !is null)
                {
                    pm.id = request.post("id").to!int;
                    pm.created = exsit_data.created;
                }
            }
            
            else
                pm.created = now;
            pm.updated = now;

            auto saveRes = pr.save(pm);
            if (saveRes !is null)
                return new RedirectResponse(request, url("system.permission.list", null, "admin"));

        }
        auto pgList = (new PermissionGroupRepository()).findAll();
        view.assign("groups", pgList);
        return ResponseView("system/permission/add");
    }


    @Action 
    Response edit(int id) {
        makePageBreadCrumbs("permissionAdd");
        logDebug(" edit id : ", id, "  get id : ", request.get("id"));
        auto repository = new PermissionRepository();
        view.assign("permission", repository.find(request.get("id").to!int));
        auto pgList = (new PermissionGroupRepository()).findAll();
        view.assign("groups", pgList);
        return ResponseView("system/permission/edit");
    }

    @Action Response del(int id)
    {
        (new PermissionRepository()).removeById(request.get("id").to!int);
        // return new RedirectResponse(request, "/admincp/system/permissions");
        return new RedirectResponse(request, url("system.permission.list", null, "admin"));
    }
}
