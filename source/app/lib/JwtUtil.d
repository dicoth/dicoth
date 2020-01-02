module app.lib.JwtUtil;

import jwt;
import hunt.logging.ConsoleLogger;
import hunt.util.Serialize;
import hunt.util.DateTime;
import std.array;


class JwtUtil {

    
    __gshared long EXPIRE_TIME = 5 * 60 * 1000;
    static string TOKEN_TYPE = "Bearer";
   
    static bool verify(string token, string secret) {
        try {
            token = token.replaceFirst("Bearer ", "");
            Token tk = jwt.verify(token, secret, [JWTAlgorithm.HS256, JWTAlgorithm.HS512]);
            return true;
        } catch (Exception e) {
            warning(e);
            return false;
        }
    }

    static bool verify(string token, string username, string secret) {
        try {
            Token tk = jwt.verify(token, secret, [JWTAlgorithm.HS256, JWTAlgorithm.HS512]);
            return true;
        } catch (Exception e) {
            warning(e);
            return false;
        }
    }

    static string getUsername(string token) {
        try {
            Token tk = decode(token);
            return tk.claims().get("username");
        } catch (Exception e) {
            warning(e);
            return null;
        }
    }

    static JwtUserInfo getInfo(string token) {
        import std.json;
        JwtUserInfo info;
        try {
            token = token.replaceFirst("Bearer ", "");
            Token tk = decode(token);
            auto jStr = tk.claims().json();
            return toObject!JwtUserInfo(parseJSON(jStr));
        } catch (Exception e) {
            warning(e);
            return info;
        }
    }

   
    static string sign(JwtUserInfo info, string secret, long expires_in = 0) {
        Token token = new Token(JWTAlgorithm.HS512);
        token.claims.exp = cast(int)time() + (expires_in > 0 ? expires_in : EXPIRE_TIME);
        auto j = toJSON!JwtUserInfo(info);
        foreach(k, v; j.object)
        {
            token.claims.set(k, v); 
        }
        return token.encode(secret);
    }



    static string generateAuthorization(string token) {
        return TOKEN_TYPE ~ " " ~ token;
    }
}

class JwtUserInfo
{
    string nickname;
    int uid;
    string username;
    string avatar;
}
