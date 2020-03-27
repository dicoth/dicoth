
import app.providers;
import app.component.system.model.LangPackage;
import app.component.system.repository.LangPackageRepository;
import app.component.system.repository.LanguageRepository;

import hunt.framework;

void main(string[] args)
{

    Application app = Application.instance();
    
    // app().accessManager.initAuthenticateProxy(new MyAuthProxy());

    // TODO: Tasks pending completion -@zhangxueping at 2020-03-03T16:05:50+08:00
    // 
    // auto langPackageRepository = new LangPackageRepository();
    // auto allData = langPackageRepository.initLangPackage();
    // I18n i18n = I18n.instance();
    // foreach(key, oneArray; allData){
    //     i18n.merge(key, oneArray);
    // }
    
    app.register!DicothAuthServiceProvider; 
    app.register!DicothBreadcrumbServiceProvider; 
    app.run(args);
}
