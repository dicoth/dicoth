module app.component.system.helper.Password;

import std.digest.sha;

string generateSalt()
{

    return "test";
}

string generateUserPassword(string password, string salt)
{
    auto sha256 = new SHA256Digest();
    ubyte[] hash256 = sha256.digest(password~salt);
    return toHexString(hash256);
}
