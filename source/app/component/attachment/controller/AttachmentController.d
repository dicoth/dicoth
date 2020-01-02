module app.component.attachment.controller.AttachmentController;

import hunt.framework;

import app.lib.BaseController;
import app.lib.NotFoundResponse;
import app.middleware.UserAuthMiddleware;
import app.component.attachment.repository.AttachmentRepository;

import std.uri;

import std.json;
import std.conv;

class AttachmentController : BaseController
{
    mixin MakeController;

    this() {
        super();
        auto middle = new UserAuthMiddleware();
        middle.setForceLoginMCA(["attachment.attachment.upload","attachment.attachment.deleteFile"]);
        this.addMiddleware(middle);
    }


    @Action JSONValue upload() {

        JSONValue res;
        import hunt.framework.file.UploadedFile;
        import app.lib.yun.FileCloud;
        import app.component.attachment.model.Attachment;
        import std.path;
        string type = request.get("type","post");
        if (request.hasFile("file")) {
            res["error_code"] = -1;
            res["filename"] = "";
            res["url"] = "";
            res["id"] = "";
            UploadedFile file = request.file("file");
            if (file.isValid()) {
                auto attachment = new Attachment();
                attachment.type = type;//"post";
                attachment.uid = this.getUserId();
                attachment.original_name = file.originalName();
                attachment.extension = std.path.extension(attachment.original_name);
                attachment.mime = file.mimeType();
                attachment.size = file.size();
                attachment.created = cast(int)time();

                auto fileCloud = new FileCloud();
                string newFilename = fileCloud.uploadToLocal(file);
                if (newFilename){
                    res["error_code"] = 0;
                    attachment.filename = newFilename;
                    auto filesRepository = new AttachmentRepository(_cManager);
                    auto attachmentData = filesRepository.findUserUploadFile(attachment.uid, newFilename);
                    if(attachmentData)
                    {
                        attachment = attachmentData;
                    }else{
                        filesRepository.insert(attachment);
                    }
                    res["id"] = attachment.id.to!string;
                    res["url"] = "/attachment/"~attachment.id.to!string;
                    res["filename"] = attachment.original_name;
                }
            }
        }
        return res;
    }

    @Action Response file(int id)
    {
        FileResponse response;

        auto fileRepository = new AttachmentRepository(_cManager);
        auto file = fileRepository.find(id);

        if(file)
        {
            import app.lib.yun.FileCloud;

            auto fileCloud = new FileCloud();
            string path = fileCloud.getLocalFilePath(file.filename);
            try
            {

                response = new FileResponse(path);
                response.setMimeType(file.mime);
                response.setHeader("Cache-Control", "max-age=86400");
                response.setHeader("content-type", file.mime);
                response.setName(file.original_name);

                response.loadData();
                if(file.extension == ".gif" || file.extension != ".jpg" || file.extension != ".png" || file.extension != "jpeg")
                {
                    response.setHeader("Content-Disposition", "");
                }
                file.downloads += 1;
                fileRepository.save(file);
            }
            catch(Exception e)
            {
                return new NotFoundResponse;
            }
        }
        else
        {
            return new NotFoundResponse;
        }

        return response;
    }
    
    @Action JSONValue deleteFile() 
    {
        JSONValue res;
        auto fileRepository = new AttachmentRepository(_cManager);
        int uid = this.getUserId();
        int id = request.post!int("id");
        res["error_code"] = 0;
        auto file = fileRepository.findAttachmentByUidAndId(uid, id);
        if(file){
            int curtime = cast(int)time();
            bool deletedRet = fileRepository.DelByPost(id, curtime);
            if(deletedRet){
                import app.lib.yun.FileCloud;
                import std.file;
                auto fileCloud = new FileCloud();
                string filename = file.filename;
                string getLocalFilePath = fileCloud.getLocalFilePath(filename);
                if(getLocalFilePath){
                    bool exist = std.file.exists(getLocalFilePath);
                    if(exist){
                        std.file.remove(getLocalFilePath);
                    }
                    return res;
                }else{
                    return res;
                }
                
            }else{
                res["error_code"] = 1;
                return res;
            }
        }
                return res;

        
    }
        
    
}
