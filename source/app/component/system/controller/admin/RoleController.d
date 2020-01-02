module app.component.system.controller.admin.RoleController;

import app.component.system.helper.Utils;
import app.component.system.model.Permission;
import app.component.system.model.PermissionGroup;
import app.component.system.model.RolePermission;
import app.component.system.model.Role;
import app.component.system.repository.PermissionRepository;
import app.component.system.repository.PermissionGroupRepository;
import app.component.system.repository.RoleRepository;
import app.component.system.repository.RolePermissionRepository;
import app.component.system.controller.AdminBaseController;
import app.lib.Functions;

import hunt.entity.DefaultEntityManagerFactory;
import hunt.framework;
import hunt.http.codec.http.model.HttpMethod;
import hunt.util.DateTime;

import std.algorithm;

class RoleController : AdminBaseController
{
    mixin MakeController;

    @Action 
    Response list(int perPage, int page = 1) {
        perPage = perPage < 1 ? 10 : perPage;
        auto alldata = (new RoleRepository()).findByRole(page-1, perPage);

        view.assign("roles", alldata.getContent());

        view.assign("pageModel",  alldata.getModel());
        view.assign("pageQuery", buildQueryString(request.input()));
        return new Response(request)
        .setHeader(HttpHeader.CONTENT_TYPE, MimeType.TEXT_HTML_UTF_8.asString())
        .setContent(view.render("system/role/list"));

    }

    @Action 
    Response add() {
        if(request.methodAsString() == HttpMethod.POST.asString()){
            string name = request.post!string("name", "");
            short status = request.post("status").to!short;
            int time = cast(int)time();
            int[] permissionIds = Utils.getCheckbox!int(request.all(), "permissionid");

            try {
                auto roleRepository = new RoleRepository();
                Role role = new Role();
                role.name = name;
                role.created = time;
                role.updated = time;
                role.status = status;

                roleRepository.save(role);
                auto rolePermissionRepository = new RolePermissionRepository();
                rolePermissionRepository.saves(role.id, permissionIds);

                Application.getInstance().accessManager.refresh();  
                return new RedirectResponse(request, url("system.role.list", null, "admin"));
            } catch(Exception e) {
                assignError("role already existed.");
            }
        }
        view.assign("permissions", (new PermissionRepository()).findAll());
        view.assign("groups", (new PermissionGroupRepository()).findAll());

        string lang = findLocal();
        return new Response(request)
            .setHeader(HttpHeader.CONTENT_TYPE, MimeType.TEXT_HTML_UTF_8.asString())
            .setContent(view.setLocale(lang).render("system/role/add"));
    }

    @Action Response edit()
    {
        int id = request.get!int("id", 0);

        auto rolePermissionRepository = new RolePermissionRepository();
        auto roleRepository = new RoleRepository();

        auto findRole = roleRepository.find(id);
        if(request.methodAsString() == HttpMethod.POST.asString())
        {
            auto params = request.all();
            string name = request.post!string("name", "");
            short status = request.post("status").to!short;
            int[] permissionIds = Utils.getCheckbox!int(request.all(), "permissionid");

            try {
                auto role = findRole;
                role.name = name;
                role.status = status;
                roleRepository.save(role);
                rolePermissionRepository.removes(id);
                rolePermissionRepository.saves(id, permissionIds);
                Application.getInstance().accessManager.refresh();  
                return new RedirectResponse(request, "/admincp/system/roles");
            } catch(Exception e) {
                assignError("error.");
            }

            return new RedirectResponse(request, "/admincp/system/role/edit?id="~to!string(id));            
        }
        view.assign("role", findRole);

        auto permissions = (new PermissionRepository()).findAll();
        int[] rolePermissionIds = rolePermissionRepository.getRolePermissionIds(id);
        class rolePermissionClass{
            Permission permission;
            string checked;
        }
        rolePermissionClass[] rolePermissions;
        foreach(key, permission; permissions){
            auto tmp =new rolePermissionClass;
            tmp.permission = permission;
            if(canFind(rolePermissionIds, permission.id)){
                tmp.checked ~= "checked";
            }else{
                tmp.checked ~= "";
            }
            rolePermissions ~= tmp;
        }
        view.assign("rolePermissions", rolePermissions);
        view.assign("groups", (new PermissionGroupRepository()).findAll());

        string lang = findLocal();
        return new Response(request)
            .setHeader(HttpHeader.CONTENT_TYPE, MimeType.TEXT_HTML_UTF_8.asString())
            .setContent(view.setLocale(lang).render("system/role/edit"));
    }
}
