module app.lib.Signature;

import std.digest.md;
import std.digest.sha;
import std.algorithm.sorting;
import hunt.logging;


string signature1(string[string] parameters, string secret)
{
    string str = "";
    string[] arr;
    foreach(key,val; parameters)
    {
        if(key != "signature")
        {
            arr ~= key;
        }
    }
    arr.sort();
    foreach(index,val; arr)
    {
        if(index > 0)
        {
            str ~= "&";
        }
        str ~= val ~ "=" ~ parameters[val];
    }
    logDebug(str);
    ubyte[] hash = md5Of(secret ~ str ~ secret).dup;
    return toHexString(hash);
}