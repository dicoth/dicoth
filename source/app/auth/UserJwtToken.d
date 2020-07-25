module app.auth.UserJwtToken;

import hunt.framework.auth;

class UserJwtToken : JwtToken {
    this(string token) {
        super(token);
    }
}
