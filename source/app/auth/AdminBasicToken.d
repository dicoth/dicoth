module app.auth.AdminBasicToken;

import hunt.framework.auth;

class AdminBasicToken : JwtToken {
    this(string token) {
        super(token);
    }
}
