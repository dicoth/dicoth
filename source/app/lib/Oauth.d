module app.lib.Oauth;

import std.net.curl;
import app.component.system.repository.SettingRepository;
import hunt.util.DateTime;
import std.json;
import std.array:split;
import std.conv;
import std.stdio;
import app.lib.Functions;


class Oauth {
    private string _channel;
    private string access_token;
    private string appid;
    private string secret;
    private string access_token_url;
    private string user_info_url;
    private string[string] options;

    this(string channel)
    {
        _channel = channel;
        if(_channel == "github"){
            appid = findConfig("github.appid");
            if(!appid){
                throw new Exception("appid is null");
            }
            secret = findConfig("github.secret");
            if(!secret){
                throw new Exception("secret is null");
            }
            access_token_url = findConfig("github.access_token_url");
            if(!access_token_url){
                throw new Exception("access_token_url is null");
            }
            user_info_url = findConfig("github.user_info_url");
            if(!user_info_url){
                throw new Exception("user_info_url is null");
            }
        }

    }

    auto get_user_info(string code)
    {
        if( _channel == "github"){
            auto content = post(access_token_url, ["client_id" : appid, "client_secret" : secret, "code" : code]);
            access_token = split(split(content, "&")[0], "=")[1].to!string;
            auto info = get(user_info_url~access_token).parseJSON;
            return info;
        }
        return JSONValue.init;
    }
}
