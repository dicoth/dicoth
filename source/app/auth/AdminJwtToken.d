module app.auth.AdminJwtToken;

import hunt.framework.auth;

class AdminJwtToken : JwtToken {
    this(string token) {
        super(token);
    }
}
