module app.lib.yun.FileCloud;

import app.lib.yun.status;
import app.lib.yun.exception;

import std.json;
import std.net.curl;
import std.array;
import std.datetime;
import std.file;
import std.digest.sha;
import std.digest.hmac;
import std.base64;
import std.conv;
import std.string;
import hunt.logging;
import hunt.framework.application.ApplicationConfig;
import hunt.util.Configuration;
import std.stdio;
import hunt.framework.file.UploadedFile;


import std.experimental.allocator.mallocator;
import core.stdc.time;


enum SliceLength =  4 * 1024 * 1024;

class FileCloud
{
    ConfigBuilder _conf;
    string localPath = "/data/dlangforum_file";
    this()
    {
        _conf = configManager().config("hunt");
        localPath = _conf.hunt.upload.doPath.value != "" ? _conf.hunt.upload.doPath.value : localPath;
    }

    string getLocalFilePath(string filename)
    {
        return localPath ~ "/"~filename[0..2]~"/"~filename[2..4]~"/"~filename;
    }

    string uploadToLocal(UploadedFile file)
    {
        import std.stdio : File;
        import std.path;
        string filename = getFileHash1(file.path()) ~ std.path.extension(file.originalName());
        string path = localPath;
        try{path.mkdir;}catch(Exception e){}

        path = path ~ "/"~filename[0..2];
        try{path.mkdir;}catch(Exception e){}

        path = path ~ "/"~filename[2..4];
        try{path.mkdir;}catch(Exception e){}

        path ~= "/"~filename;
        if(path.exists)
        {
            try{file.path().remove;}catch(Exception e){}
            return filename;
        }
        
        file.move(path);
        return filename;
    }

    string uploads(UploadedFile file)
    {
        Appender!(ubyte[]) postData;
        HTTP http = HTTP();
        http.url(_conf.filecloud.write.value);
        http.method(HTTP.Method.post);
        string boundary = "031234126501963661110959";

        postData.put(cast(ubyte[])(`----------------------------`~boundary));
        postData.put(cast(ubyte[])"\r\n");
        postData.put(cast(ubyte[])`Content-Disposition: form-data; name="appid"`);
        postData.put(cast(ubyte[])"\r\n\r\n");
        postData.put(cast(ubyte[])`3005`);

        postData.put(cast(ubyte[])"\r\n");

        postData.put(cast(ubyte[])(`----------------------------`~boundary));
        postData.put(cast(ubyte[])"\r\n");
        postData.put(cast(ubyte[])`Content-Disposition: form-data; name="uploadToken"`);
        postData.put(cast(ubyte[])"\r\n\r\n");
        postData.put(cast(ubyte[])buildToken());

        postData.put(cast(ubyte[])"\r\n");

        postData.put(cast(ubyte[])(`----------------------------`~boundary));
        postData.put(cast(ubyte[])"\r\n");
        postData.put(cast(ubyte[])`Content-Disposition: form-data; name="filename"`);
        postData.put(cast(ubyte[])"\r\n\r\n");
        postData.put(cast(ubyte[])`pic2.jpg`);

        postData.put(cast(ubyte[])"\r\n");

        postData.put(cast(ubyte[])(`----------------------------`~boundary));
        postData.put(cast(ubyte[])"\r\n");
        postData.put(cast(ubyte[])(`Content-Disposition: form-data; name="file"; filename="`~file.originalName()~`"`));
        postData.put(cast(ubyte[])"\r\n");
        postData.put(cast(ubyte[])(`Content-Type: `~file.mimeType()));
        postData.put(cast(ubyte[])"\r\n\r\n");

        import std.stdio : File;
        auto f = File(file.path(), "rb");
        scope(exit) f.close();
        ubyte[] buf = new ubyte[512];
        ubyte[] buf1;
        ubyte[1024] data;
        SHA1 sha1;
        while((buf1 = f.rawRead(buf)).length > 0) {
            sha1.start();
            sha1.put(buf1);
            postData.put(buf1);
        }
        postData.put(cast(ubyte[])"\r\n");
        string hash1 = toLower(toHexString(sha1.finish()));
        postData.put(cast(ubyte[])(`----------------------------`~boundary));
        postData.put(cast(ubyte[])"\r\n");
        postData.put(cast(ubyte[])`Content-Disposition: form-data; name="sha1"`);
        postData.put(cast(ubyte[])"\r\n\r\n");
        postData.put(cast(ubyte[])hash1);

        postData.put(cast(ubyte[])"\r\n");

        postData.put(cast(ubyte[])(`----------------------------`~boundary~`--`));
        postData.put(cast(ubyte[])"\r\n");

        http.setPostData(postData.data,"multipart/form-data; boundary=--------------------------"~boundary);
        Appender!(ubyte[]) revData = appender!(ubyte[]);
        http.onReceive = (ubyte[] rev){revData.put(rev); return rev.length;};
        http.perform();
        auto j = parseJSON(cast(string)revData.data);
        if("hash" !in j)
        {
            return "";
        }
        return _conf.filecloud.read.value~j["hash"].str~"."~j["ext"].str;
    }

    string getFileHash1(string filename)
    {
        import std.digest.digest;
        import std.digest.sha;
        import std.string;

        File file = File(filename,"r");
        SHA1 ahs = SHA1();
        ahs.start();
        ubyte[] data = new ubyte[4 * 1024];
        scope(exit){
            import core.memory;
            GC.free(data.ptr);
        }
        while(!file.eof){
            auto tdata = file.rawRead(data);
            ahs.put(tdata);
        }
        auto sha  = ahs.finish;
        auto str = toHexString(sha);
        string tstr = cast(string)(str[]);
        return toLower(tstr);
    }
protected:

    string buildToken()
    {
        time_t deadline = time(null);
        string str = "{\"deadline\":" ~ to!string((cast(int)deadline + _conf.filecloud.deadline.value.to!int)) ~ "}";
        string enc_str = Base64URL.encode(cast(byte[])str);
        auto hmac = HMAC!SHA1(cast(ubyte[])_conf.filecloud.secretKey.value);
        hmac.put(cast(ubyte[])enc_str);
        string hmac_str = Base64URL.encode(hmac.finish());
        return (_conf.filecloud.accessKey.value ~ ":" ~ hmac_str ~ ":" ~ enc_str);
    }
}
