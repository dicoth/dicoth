module app.component.user.helper.AuthHelper;

class AuthHelper
{
    static signPassword(string password, string salt)
    {
        import hunt.logging;
        import std.digest;
        import std.digest.hmac;
        import std.digest.sha;
        import std.string : representation;
        import std.uni;

        auto hmac = HMAC!SHA1(salt.representation);
        auto digest = hmac.put(password.representation).finish();
        string f = cast(string)digest.toHexString().dup();
        return f;
    }
}