module app.data.DicothUserService;

import hunt.framework;

import hunt.logging.ConsoleLogger;

import app.component.user.repository.UserRepository;
import app.component.user.helper.AuthHelper;
import app.component.user.model.User;

/**
 * 
 */
class DicothUserService : UserService {

    UserDetails authenticate(string username, string password) {
        UserRepository repo = new UserRepository();
        User userinfo = repo.findUserByUsername(username);
        if(userinfo is null) {
            userinfo = repo.findUserByEmail(username);
        }

        if(userinfo is null)
            return null;

        string passwordInput = AuthHelper.signPassword(password, userinfo.salt);
        if(userinfo.password != passwordInput) {
            return null;
        }
        
        return mapping(userinfo);
    }

    string getSalt(string name, string password) {   
        UserRepository repo = new UserRepository();
        User userInfo = repo.findUserByUsername(name);
        if(userInfo is null)
            return null;

        return userInfo.salt;   
    }

    UserDetails getByName(string name) {
        UserRepository repo = new UserRepository();

        User userInfo = repo.findUserByUsername(name);
        if(userInfo is null)
            return null;

        // UserDetails details = new UserDetails();
        // details.id = cast(ulong)userInfo.id;
        // details.name = userInfo.username;
        // details.permissions

        return mapping(userInfo);
    }

    private static UserDetails mapping(User user) {
        UserDetails details = new UserDetails();

        details.id = cast(ulong)user.id;
        details.name = user.username;
        details.addClaim(ClaimTypes.Nickname, user.nickname);
        details.addClaim("avatar", user.avatar);

        return details;
    }

    UserDetails getById(ulong id) {
        UserRepository repo = new UserRepository();

        User userInfo = repo.findById(cast(int)id);
        if(userInfo is null)
            return null;

        UserDetails details = new UserDetails();
        details.id = cast(ulong)userInfo.id;
        details.name = userInfo.username;
        // details.permissions

        return details;
    }
}