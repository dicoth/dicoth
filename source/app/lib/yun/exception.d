module app.lib.yun.exception;

import std.exception;
import hunt.Exceptions;
import hunt.shiro.Exceptions;

class YunSdkException : Exception
{
    mixin basicExceptionCtors;
}

class FileNotExistsException : Exception
{
    mixin basicExceptionCtors;
}

class WrongPasswordException : AuthorizationException {
    mixin BasicExceptionCtors;
}

class WrongEmailException : AuthorizationException {
    mixin BasicExceptionCtors;
}
