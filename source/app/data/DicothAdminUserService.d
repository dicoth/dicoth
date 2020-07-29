module app.data.DicothAdminUserService;

import hunt.framework;

import hunt.logging.ConsoleLogger;

import app.component.system.repository.UserRepository;

import app.component.system.helper.Password;
import app.component.system.model.User;
import app.component.system.model.Role;

// import app.component.user.repository.UserRepository;
// import app.component.user.helper.AuthHelper;
// import app.component.user.model.User;

/**
 * 
 */
class DicothAdminUserService : UserService {

    UserDetails authenticate(string username, string password) {
        UserRepository repo = new UserRepository();
        User userinfo =  repo.findByEmail(username);

        if(userinfo is null)
            return null;

        string passwordInput = generateUserPassword(password, userinfo.salt); // AuthHelper.signPassword(password, userinfo.salt);
        if(userinfo.password != passwordInput) {
            return null;
        }
        
        return mapping(userinfo);
    }

    string getSalt(string name, string password) {   
        UserRepository repo = new UserRepository();
        User userInfo = repo.findByEmail(name);
        if(userInfo is null)
            return null;

        return userInfo.salt;   
    }

    UserDetails getByName(string name) {
        UserRepository repo = new UserRepository();

        User userInfo = repo.findByEmail(name);
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
        details.name = user.email;
        details.salt = user.salt;
        details.fullName = user.name;
        
        details.addClaim("lang", user.language);

        return details;
    }

    UserDetails getById(ulong id) {
        UserRepository repo = new UserRepository();

        User userInfo = repo.findById(cast(int)id);
        if(userInfo is null)
            return null;

        // UserDetails details = new UserDetails();
        // details.id = cast(ulong)userInfo.id;
        // details.name = userInfo.email;
        // details.salt = userInfo.salt;
        // details.permissions

        return mapping(userInfo);
    }
}
