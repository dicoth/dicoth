module app.util.Exceptions;

import hunt.Exceptions;
import hunt.shiro.Exceptions;

class WrongPasswordException : AuthorizationException {
    mixin BasicExceptionCtors;
}

class WrongEmailException : AuthorizationException {
    mixin BasicExceptionCtors;
}
