module app.config.DicothConfig;

import hunt.util.Configuration;

@ConfigurationFile("dicoth")
class DicothConfig {

    string test = "test";

    PassportConfig passport;
    FileCloudConfig filecloud;
    GithubConfig github;
    WeiboConfig weibo;
    QQConfig qq;
    WechatConfig wechat;
}

struct PassportConfig {
    bool enabled = false;
    string appid;
    string secret;
    string host;
    string ssoinfo;
    string islogin;
}

struct FileCloudConfig {
    string appid;
    int deadline;
    string write;
    string read;
    string check;
    string accessKey;
    string secretKey;
}

struct GithubConfig {
    string appid;
    string secret;
    string accessTokenUrl;
    string userInfoUrl;
}

struct WeiboConfig {
    string appid;
    string secret;
    string accessTokenUrl;
    string userInfoUrl;
}

struct QQConfig {
    string appid;
    string secret;
    string accessTokenUrl;
    string userInfoUrl;
}

struct WechatConfig {
    string appid;
    string secret;
    string accessTokenUrl;
    string userInfoUrl;
}
