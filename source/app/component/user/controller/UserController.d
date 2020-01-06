module app.component.user.controller.UserController;

import hunt.framework;
import app.lib.BaseController;

import app.lib.JwtUtil;
import hunt.logging;

import app.component.user.repository.UserRepository;
import app.component.forum.repository.PostRepository;
import app.component.forum.repository.ThreadRepository;
import app.component.forum.repository.ForumRepository;
import app.component.forum.model.Thread;
import app.component.forum.model.Post;
import std.uri;
import app.middleware.UserAuthMiddleware;
import app.lib.captcha;
import app.component.user.form.RegisterForm;
import app.component.user.form.LoginForm;
import app.component.user.model.User;
import app.component.user.repository.UserRepository;
import app.component.user.model.UserVerifycode;
import app.component.user.model.UserOauth;

import app.component.user.repository.UserVerifycodeRepository;
import app.component.user.repository.UserOauthRepository;
import app.lib.Functions;
import std.stdio;
import std.conv;
import std.range;
import app.component.user.form.UserinfoForm;
import app.component.user.form.OauthLoginForm;

import arsd.email;
import std.typecons;
import app.component.user.helper.AuthHelper;
import core.time;
import app.task.EmailTask;

class UserController : BaseController
{
    mixin MakeController;

    this() {
        super();
        auto middle = new UserAuthMiddleware();
        middle.setForceLoginMCA(["user.user.editPassword", "user.user.settings", "user.user.editprofile", "user.user.logout"]);
        this.addMiddleware(middle);
    }

    @Action string sendCode(){ 
        string touser = request.input("account","");  
        string code_type = request.input("code_type",""); // email: 1 phone： 2
        auto userinfo = new UserRepository().findUserByEmail(touser);
        if(userinfo !is null){
            return "This email has been existed, please change a new one";
        }
        string code = randCode();
        string body = "Your registration code is：" ~ code;
        string subject = "Dlang Chinese Forum Registration Code";
		auto emailTask = new EmailTask(touser, body, subject);
        emailTask.setFinish((Task t) {
			try {
                string id = to!string(t.tid);
                GetTaskMObject.del(to!size_t(id));
			} catch (Exception e) {
			}
		});
		GetTaskMObject().put(emailTask, dur!"seconds"(5));
        int now = cast(int) time();
        UserVerifycode userVerifycode = new UserVerifycode();
        UserVerifycodeRepository userVerifycodeRepository = new UserVerifycodeRepository();
        auto rcodeinfo = userVerifycodeRepository.findByAccountCodeRecenty(touser);
        if(rcodeinfo !is null ){  
            return "Please wait a moment to try again.";  
        }
        userVerifycode.account = touser;
        userVerifycode.code = code;
        userVerifycode.code_type = 1;
        userVerifycode.created = now;
        userVerifycode.updated = now;
        userVerifycode.status = 1;
        userVerifycodeRepository.insert(userVerifycode);
        return "ok";  
    }

     
     @Action Response checkCode(){ 
        string touser = request.input("account","");  
        string code = request.input("code");
        string code_type = request.input("code_type","1"); 
        
        UserVerifycodeRepository userVerifycodeRepository = new UserVerifycodeRepository();
        auto codeinfo = userVerifycodeRepository.findByAccountCode(touser,code);
        if(codeinfo is null ){
            return new Response(request)
            .setHeader(HttpHeader.CONTENT_TYPE, MimeType.TEXT_HTML_UTF_8.asString())
            .setContent("Your email validation code is invalid");
        }
        
        request.session().set("regaccount", touser);
       
        return new Response(request)
            .setHeader(HttpHeader.CONTENT_TYPE, MimeType.TEXT_HTML_UTF_8.asString())
            .setContent("<script>;window.window.location.href='"~url("user.user.register")~"';</script>");
        
    } 

    @Action Response getCaptcha()
    {
        import std.stdio;
        import std.conv;
        enum int gifsize=17646;
        ubyte[] l = new ubyte[5];
        ubyte[] im = new ubyte[70*200];
        ubyte[] gif = new ubyte[gifsize];
        captcha(im, l);
        makegif(im, gif);
        writeln(cast(string)l);
        request.session().set("captcha", cast(string)l);
        return new Response(request)
        .setHeader(HttpHeader.CONTENT_TYPE, MimeType.IMAGE_GIF_VALUE.to!string)
        .setContent(gif);
    }

    @Action Response register(RegisterForm form)
    {
        if(request.method() == HttpMethod.POST)
        {
  
            auto result = form.valid();
            if(!result.isValid){
                auto errors = result.messages();
                string errorMsg;
                foreach(error; errors){
                    errorMsg = error;
                    break;
                }
                return new Response(request)
                .setHeader(HttpHeader.CONTENT_TYPE, MimeType.TEXT_HTML_UTF_8.asString())
                .setContent("<script>alert('"~errorMsg~"');window.history.back(-1);</script>");
            }
            if(form.password != form.rpassword)
            {
                return new Response(request)
                .setHeader(HttpHeader.CONTENT_TYPE, MimeType.TEXT_HTML_UTF_8.asString())
                .setContent("<script>alert('two password entries are inconsistent!');window.history.back(-1);</script>");
            }
            string captcha = request.session().get("captcha");
            if(form.captcha == "" || captcha != form.captcha)
            {
                request.session().remove("captcha");
                return new Response(request)
                .setHeader(HttpHeader.CONTENT_TYPE, MimeType.TEXT_HTML_UTF_8.asString())
                .setContent("<script>alert('captcha invalid!');window.history.back(-1);</script>");
            }
            auto userRep = new UserRepository();
            if(userRep.findUserByUsername(form.username))
            {
                return new Response(request)
                .setHeader(HttpHeader.CONTENT_TYPE, MimeType.TEXT_HTML_UTF_8.asString())
                .setContent("<script>alert('This username had been existed');window.history.back(-1);</script>");
            }
            string mail = request.session().get("regaccount");
            auto curtime = cast(int)time();
            auto userModel = new User();
            userModel.username = form.username;
            userModel.nickname = form.nickname;
            userModel.email = mail;
            userModel.salt = rnd(8);
            userModel.password = AuthHelper.signPassword(form.password, userModel.salt);
            userModel.status = 1;
            userModel.updated = curtime;
            userModel.ip = client_ip();
            userModel.created = curtime;
            auto userRet = userRep.insert(userModel);
            
            session.remove("regaccount");
            
            auto userVerifycodeRepository = new UserVerifycodeRepository();
                userVerifycodeRepository.updateStatus(mail);
            
            string oauth_token = request.cookie("__oauth_token__");
            if(oauth_token){
                auto userOauthRepository = new UserOauthRepository(_cManager);
                auto UserOauthInfo = userOauthRepository.findByOauthToken(oauth_token);
                if(!UserOauthInfo){
                    auto userOauthModel = new UserOauth();
                    userOauthModel.uid = userRet.id;
                    userOauthModel.oauth_token = oauth_token;
                    userOauthModel.flag = 1;
                    userOauthModel.created = curtime;
                    userOauthModel.updated = curtime;
                    userOauthRepository.insert(userOauthModel);
                }
                
            }
            return new Response(request)
            .setHeader(HttpHeader.CONTENT_TYPE, MimeType.TEXT_HTML_UTF_8.asString())
            .setContent("<script>alert('registration success!');window.window.location.href='"~url("user.user.login")~"';</script>");
        }
        string regaccount = request.session().get("regaccount");
        view.assign("regaccount",regaccount);
        
        return new Response(request)
        .setHeader(HttpHeader.CONTENT_TYPE, MimeType.TEXT_HTML_UTF_8.asString())
        .setContent(view.render("register"));
    }

    @Action Response login(LoginForm form)
    {
        
        string redirect_uri = request.get("redirect_uri");
        string ationurl = "/login";
        string[string] errorsArr;

        if(!redirect_uri.empty){
            ationurl = ationurl~"?redirect_uri="~redirect_uri;
        }

        view.assign("ationurl",ationurl);
        
        string client_id = findConfig("github.appid");
        view.assign("client_id",client_id);
        if (request.method == HttpMethod.POST)
        {
            view.assign("username", form.username);
            auto result = form.valid();
            if(!result.isValid){
                view.assign("errors", result.messages());
                return new Response(request)
                .setHeader(HttpHeader.CONTENT_TYPE, MimeType.TEXT_HTML_UTF_8.asString())
                .setContent(view.render("user/login"));
            }
            string username = form.username;
            string password = form.password;
            auto userRep = new UserRepository();
            auto userinfo = userRep.findUserByUsername(username);
            if(!userinfo){
                userinfo = userRep.findUserByEmail(username);
                if(!userinfo){
                    errorsArr["error"] ="user not exist";
                    view.assign("errors", errorsArr);
                    return new Response(request)
                    .setHeader(HttpHeader.CONTENT_TYPE, MimeType.TEXT_HTML_UTF_8.asString())
                    .setContent(view.render("user/login"));
                    }
                }

            string passwordInput = AuthHelper.signPassword(password,userinfo.salt);
            if(userinfo.password != passwordInput){
                errorsArr["error"] ="username or password validation failed";
                view.assign("errors", errorsArr);
                return new Response(request)
                .setHeader(HttpHeader.CONTENT_TYPE, MimeType.TEXT_HTML_UTF_8.asString())
                .setContent(view.render("user/login"));
            }

            auto JwtUserinfo = new JwtUserInfo();
            JwtUserinfo.username = userinfo.username;
            JwtUserinfo.uid = userinfo.id;
            JwtUserinfo.nickname = userinfo.nickname;
            JwtUserinfo.avatar = userinfo.avatar;

           
            long expireSecond = 86400;
            if(form.remember_me == 1)
            {
                expireSecond= 2592000;
            }
            string tokenString = JwtUtil.sign(JwtUserinfo, configManager().config("hunt").hunt.application.secret.value, expireSecond);
            Cookie sessionCookie = new Cookie("__auth_token__", tokenString, expireSecond.to!int);
            
            JSONValue uinfo = toJson(JwtUserinfo);
            string uinfostr = uinfo.toString;
            Cookie userCookie = new Cookie("userinfo", uinfostr, expireSecond.to!int);
           
            string tourl = "";
            if(!redirect_uri.empty){
                tourl = redirect_uri;

            }else{
                tourl = url("forum.forum.list");
            }
            Application.getInstance().cache().set("user_login_token_"~userinfo.id.to!string, tokenString, cast(uint)expireSecond);
            
            return new RedirectResponse(request, tourl)
                            .withCookie(userCookie)
                            .withCookie(sessionCookie);
        }

        view.assign("errors", errorsArr);
        return new Response(request)
        .setHeader(HttpHeader.CONTENT_TYPE, MimeType.TEXT_HTML_UTF_8.asString())
        .setContent(view.render("user/login"));
    }
    
    @Action Response settings(){

        int userid = this.getUserId();
        auto userRepository = new  UserRepository(_cManager);
        auto userInfo = userRepository.findById(userid);
        view.assign("userInfo",userInfo);
        
        return new Response(request)
        .setHeader(HttpHeader.CONTENT_TYPE, MimeType.TEXT_HTML_UTF_8.asString())
        .setContent(view.render("user/setting"));
    }
    
    @Action string editprofile(UserinfoForm form){

        auto result = form.valid();
        if(!result.isValid){
            auto errors = result.messages();
            string errorMsg;
            foreach(error; errors){
                errorMsg = error;
                break;
            }
            return errorMsg;
        }

        int userid = this.getUserId();
        auto userRepository = new  UserRepository(_cManager);
        auto userInfo = userRepository.findById(userid);

        userInfo.nickname = form.nickname;
        // userInfo.email = form.email;
        userInfo.introduce = form.introduce;
        userInfo.avatar = form.avatar;


        userRepository.save(userInfo);

        return "1";
    }

    
    @Action string editPassword(){

        string current_password = request.post("current_password");
        string password = request.post("password");
        string user_password_confirmation = request.post("user_password_confirmation");
        if(password !=user_password_confirmation ){
            return "The passwords entered twice are different";
        }

        int uid = this.getUserId();
        auto userRepository = new  UserRepository(_cManager);
        auto userInfo = userRepository.findById(uid);

        string current_password_in = AuthHelper.signPassword(current_password,userInfo.salt);//userRepository.createPassword(current_password,userInfo.salt);
        string current_password_db = userInfo.password;


        if(current_password_in != current_password_db){
            return "The previous password is incorrect";
        }
        
        string password_new = AuthHelper.signPassword(password,userInfo.salt);//userRepository.createPassword(password,userInfo.salt);
        auto curtime = cast(int)time();
        
        userInfo.password = password_new;
        userInfo.updated = curtime;

        auto info = userRepository.save(userInfo);
        return "1";
    }

    @Action
    Response profile(int id)
    {
        auto uriarr = request.getURI();// httpUri
        string tab = request.input("tab", "");
        auto userRepository = new UserRepository(_cManager);
        auto userInfoData = userRepository.findUserInfo(id);    
        if (!userInfoData)
        {
            return new Response(request)
            .setHeader(HttpHeader.CONTENT_TYPE, MimeType.TEXT_HTML_UTF_8.asString())
            .setContent(errorPageHtml(404));
        }
        view.assign("userInfo", userInfoData);
        auto threadRepository = new ThreadRepository(_cManager);
        auto threadDatas = threadRepository.findHotByUid(id, 10);
        view.assign("threads", threadDatas);

        auto forumRepository = new ForumRepository(_cManager);
        
        view.assign("threadForums", forumRepository.findAllByUsable(threadDatas));
        auto postRepository = new PostRepository(_cManager);
        auto countres = postRepository.findCountByUid(id);
        view.assign("postCount", countres);

        view.assign("breadcrumbs", breadcrumbsManager.generate("user.user.profile", userInfoData));

        return new Response(request)
        .setHeader(HttpHeader.CONTENT_TYPE, MimeType.TEXT_HTML_UTF_8.asString())
        .setContent(view.render("user/home"));
    }

    @Action Response logout()
    {

        
        Cookie sessionCookieToken = new Cookie("__auth_token__","",0);
        Cookie sessionCookieUser = new Cookie("userinfo","",0);
        Cookie sessionCookieSession = new Cookie("hunt_session","",0);

        return new RedirectResponse("/")
                .withCookie(sessionCookieToken)
                .withCookie(sessionCookieUser)
                .withCookie(sessionCookieSession);
        
    }
   
    @Action
    Response oauth(string code)
    {
        try{
                import app.lib.Oauth;
                auto oauth = new Oauth("github");
                if(!code){
                    return new Response(request)
                    .setHeader(HttpHeader.CONTENT_TYPE, MimeType.TEXT_HTML_UTF_8.asString())
                    .setContent("<script>alert('Wrong parameter !');window.history.back(-1);</script>");       
                }
         
                JSONValue oauthUserInfo = oauth.get_user_info(code);    
                string oauthToken = oauthUserInfo["id"].to!string;
                auto userOauthRepository = new UserOauthRepository(_cManager);
                auto userRep = new UserRepository();
                int uid;
                if(oauthToken){
                        auto UserOauthInfo = userOauthRepository.findByOauthToken(oauthToken);                        
                        if(!UserOauthInfo){
                            Cookie oauthCookie = new Cookie("__oauth_token__", oauthToken,3600);
                            new Response(request).withCookie(oauthCookie);
                            string tourl = "/user/oauthlogin";
                            return new RedirectResponse(request, tourl);
                        }
                        uid = UserOauthInfo.uid;
                }else{
                    return new Response(request)
                    .setHeader(HttpHeader.CONTENT_TYPE, MimeType.TEXT_HTML_UTF_8.asString())
                    .setContent("<script>alert('Error hanppend !');window.history.back(-1);</script>");
                }

                auto userinfo = userRep.findUserInfo(uid);
                if(userinfo){
                    auto JwtUserinfo = new JwtUserInfo();
                    JwtUserinfo.username = userinfo.username;
                    JwtUserinfo.uid = uid;
                    JwtUserinfo.nickname = userinfo.nickname;
                    JwtUserinfo.avatar = userinfo.avatar;
                    
                    long expireSecond = 86400;
                    
                    string tokenString = JwtUtil.sign(JwtUserinfo, configManager().config("hunt").hunt.application.secret.value, expireSecond);
                    Cookie sessionCookie = new Cookie("__auth_token__", tokenString);
                    
                    JSONValue uinfo = toJson(JwtUserinfo);
                    string uinfostr = uinfo.toString;
                    Cookie userCookie = new Cookie("userinfo", uinfostr);
                    
                    string tourl = "";
                    tourl = url("forum.forum.list");

                    Application.getInstance().cache().set("user_login_token_"~uid.to!string, tokenString, cast(uint)expireSecond);
                    
                    return new RedirectResponse(request, tourl)
                                    .withCookie(userCookie)
                                    .withCookie(sessionCookie);
                }else{
                    return new Response(request)
                    .setHeader(HttpHeader.CONTENT_TYPE, MimeType.TEXT_HTML_UTF_8.asString())
                    .setContent("<script>alert('Error data !');window.history.back(-1);</script>");
                }
        }catch(Exception e){
            return new Response(request)
                    .setHeader(HttpHeader.CONTENT_TYPE, MimeType.TEXT_HTML_UTF_8.asString())
                    .setContent("<script>alert('"~e.msg~"');window.history.back(-1);</script>");
         } 
        
    }
    
    @Action  
    Response oauthLogin(OauthLoginForm form)
    {
        string actionurl = "/user/oauthlogin";
        string[string] errorsArr;
        view.assign("actionurl",actionurl);
        if (request.method == HttpMethod.POST)
        {
            view.assign("username", form.username);
            auto result = form.valid();
            if(!result.isValid){
                view.assign("errors", result.messages());
                return new Response(request)
                .setHeader(HttpHeader.CONTENT_TYPE, MimeType.TEXT_HTML_UTF_8.asString())
                .setContent(view.render("user/oauthlogin"));
            }
            string username = form.username;
            string password = form.password;
            auto userRep = new UserRepository();
            auto userinfo = userRep.findUserByUsername(username);
            if(!userinfo){
                userinfo = userRep.findUserByEmail(username);
                if(!userinfo){
                    errorsArr["error"] ="user not exist";
                    view.assign("errors", errorsArr);
                    return new Response(request)
                    .setHeader(HttpHeader.CONTENT_TYPE, MimeType.TEXT_HTML_UTF_8.asString())
                    .setContent(view.render("user/oauthlogin"));
                    }
                }

            string passwordInput = AuthHelper.signPassword(password,userinfo.salt);//userRep.createPassword(password,userinfo.salt);
            if(userinfo.password != passwordInput){
                errorsArr["error"] ="username or password validation failed";
                view.assign("errors", errorsArr);
                return new Response(request)
                .setHeader(HttpHeader.CONTENT_TYPE, MimeType.TEXT_HTML_UTF_8.asString())
                .setContent(view.render("user/oauthlogin"));
            }

            auto JwtUserinfo = new JwtUserInfo();
            JwtUserinfo.username = userinfo.username;//username;
            JwtUserinfo.uid = userinfo.id;
            JwtUserinfo.nickname = userinfo.nickname;
            JwtUserinfo.avatar = userinfo.avatar;

            
            long expireSecond = 86400;
            if(form.remember_me == 1)
            {
                expireSecond= 2592000;
            }
            string tokenString = JwtUtil.sign(JwtUserinfo, configManager().config("hunt").hunt.application.secret.value, expireSecond);
            Cookie sessionCookie = new Cookie("__auth_token__", tokenString);
            
            JSONValue uinfo = toJson(JwtUserinfo);
            string uinfostr = uinfo.toString;
            Cookie userCookie = new Cookie("userinfo", uinfostr);
            
            string tourl = "";
            tourl = url("forum.forum.list");
            
            Application.getInstance().cache().set("user_login_token_"~userinfo.id.to!string, tokenString, cast(uint)expireSecond);
            
            string oauth_token = request.cookie("__oauth_token__");
            if(!oauth_token){
                errorsArr["error"] ="Your github token has been expired";
                view.assign("errors", errorsArr);
                return new Response(request)
                .setHeader(HttpHeader.CONTENT_TYPE, MimeType.TEXT_HTML_UTF_8.asString())
                .setContent(view.render("user/login"));
            }
            

            
            auto curtime = cast(int)time();
            auto userOauthModel = new UserOauth();
            userOauthModel.uid = userinfo.id;
            userOauthModel.oauth_token = oauth_token;
            userOauthModel.flag = 1;
            userOauthModel.created = curtime;
            userOauthModel.updated = curtime;
            auto userOauthRepository = new UserOauthRepository(_cManager);
            userOauthRepository.insert(userOauthModel);
            
            
            return new RedirectResponse(request, tourl)
                            .withCookie(userCookie)
                            .withCookie(sessionCookie);
        }
        view.assign("errors", errorsArr);
        return new Response(request)
        .setHeader(HttpHeader.CONTENT_TYPE, MimeType.TEXT_HTML_UTF_8.asString())
        .setContent(view.render("user/oauthlogin"));
        
    }

}
