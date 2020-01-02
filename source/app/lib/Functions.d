module app.lib.Functions;

import std.digest;
import std.uni;
import hunt.framework.util.Random;
import hunt.framework;
import app.component.system.repository.UserRepository;
import app.component.system.repository.SettingRepository;
import app.component.system.model.User;
import hunt.framework.application.ApplicationConfig;
import hunt.entity.DefaultEntityManagerFactory;
import hunt.logging;
import std.conv;

string client_ip()
{
    import hunt.framework.http.Request;
    import std.array;
    if(request().headerExists("X-Forwarded-For"))
    {
        string ips = request().header("X-Forwarded-For");
        auto arr = ips.split(",");
        if(arr.length >= 0)
            return arr[0];
    }
    return request().clientAddress().toAddrString();
}

string rnd(short len)
{
    return toLower(toHexString(getRandom(16)))[0 .. len];
}
string http_build_query(string[string] parameters)
{
    string str;
    short index;
    foreach(key, parameter; parameters)
    {
        if(index > 0)
        {
            str ~= "&";
        }
        str ~= key ~ "=" ~ parameter;
        index++;
    }
    return str;
}


string getAttachmentUrl(int id)
{
    return "/attachment/" ~ id.to!string;
}


string findLocal() {
    EntityManager _myManager;
    string localLanguage = configManager().config("hunt").hunt.application.defaultLanguage.value;
    auto userInfo = Application.getInstance().accessManager.user;
    if(userInfo !is null){
        auto user = new UserRepository().find(userInfo.id);
        if(user !is null){
            localLanguage = user.language;
        }
    }
    return localLanguage;
}

string findConfig(string key) {
    auto settingRepository = new SettingRepository();
    auto item = settingRepository.findByKey(key);
    if(item !is null){
        return item.value;
    }else{
        return "";
    }

}

string buildQueryString(string[string] params, string pageKey = "page")
{
    string resStr;
    foreach(key, val; params)
    {
        if(pageKey != key)
        {
            if(resStr.length > 0)
            {
                resStr ~= "&";
            }
            resStr ~= key ~ "=" ~ val;
        }
    }
    return resStr;
}

string sendMailCode(string toUser,string bodyText,string subject="D language forum registration verification code"){
        import arsd.email;
		import std.typecons;
        RelayInfo mailServer;
        string mailSmtpProtocolValue;
        string mailSmtpHostValue;
        string mailSmtpUserValue;
        string mailSmtpPasswordValue;
        string mailSmtpFromValue;

        mailSmtpProtocolValue = findConfig("mail.smtp.protocol");
        mailSmtpHostValue = findConfig("mail.smtp.host");
        mailSmtpUserValue = findConfig("mail.smtp.user");
        mailSmtpPasswordValue = findConfig("mail.smtp.password");
        mailSmtpFromValue = findConfig("mail.smtp.from");
        
        mailServer.server = mailSmtpProtocolValue~"://" ~mailSmtpHostValue;
        mailServer.username = mailSmtpUserValue;
        mailServer.password = mailSmtpPasswordValue;
        auto message = new EmailMessage();
        message.to ~= toUser ;
        message.from = mailSmtpFromValue;
        message.subject = subject;
        message.setTextBody(bodyText) ;
        message.send(mailServer); 
        return "ok";
}

string randCode(){
    import std.random;
    
    string code = uniform(100000, 999999).to!string;
    return code;
}

static int initNum(string paramName, int initValue = 1, string reqType = "POST"){
    import std.array, std.string;
    int resNum;
    if(paramName && reqType){
        string param;
        if(reqType == "POST"){
            param = request.post(paramName, initValue.to!string).replace(" ", "");
        }else{
            param = request.get(paramName, initValue.to!string).replace(" ", "");
        }
        resNum = isNumeric(param) ? to!int(param) : initValue;
    }
    return resNum;
}
