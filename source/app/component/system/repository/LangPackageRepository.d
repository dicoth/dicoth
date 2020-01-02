module app.component.system.repository.LangPackageRepository;

import hunt.framework;
import hunt.entity;
import hunt.entity.repository;
import hunt.logging;
import app.component.system.model.LangPackage;
import app.component.system.model.Language;
import app.component.system.repository.LanguageRepository;
import std.algorithm;

class LangPackageRepository : EntityRepository!(LangPackage, int) {

    this() {
        super(defaultEntityManager());
    }

    Page!LangPackage findByLangPackage(int page = 1, int perPage = 10) {
        page = page < 1 ? 1 : page;
        perPage = perPage < 1 ? 10 : perPage;
        string sql = "SELECT l FROM LangPackage l";
        auto temp = _manager.createQuery!(LangPackage)(sql, new Pageable(page - 1, perPage))
            .getPageResult();
        return temp;
    }


    LangPackage findPackageBySign(string local){
        return _manager.createQuery!(LangPackage)(" SELECT p FROM LangPackage p WHERE p.local = :local")
            .setParameter("local", local)
            .getSingleResult();
    }

    int isSet(string local, string key){
        string sql = " SELECT p FROM LangPackage p WHERE p.local = :local AND p.key = :key LIMIT 1 ";
        auto lp = _manager.createQuery!(LangPackage)(sql)
            .setParameter("local", local)
            .setParameter("key", key)
            .getSingleResult();
        if(lp !is null)
            return 1;
        return 0;
    }

    string[string][string] initLangPackage(){
        string[string][string] res;
        auto languages = _manager.createQuery!(Language)(" SELECT p FROM Language p WHERE p.status = 1 ")
            .getResultList();
        foreach(language; languages){
            auto datas = _manager.createQuery!(LangPackage)(" SELECT p FROM LangPackage p WHERE p.local = :local ")
                .setParameter("local", language.sign)
                .getResultList();
            string[string] tmp;
            foreach(data; datas){
                tmp[data.key] = data.value;
            }
            if(tmp !is null) res[language.sign] = tmp;
        }
        return res;
    }

    LangPackage findByKeyword(string local, string key){
        return _manager.createQuery!(LangPackage)("SELECT p FROM LangPackage p WHERE p.local = :local and p.key = :key")
            .setParameter("local", local)
            .setParameter("key", key)
            .getSingleResult();
    }

    int findKey(string key){
        return cast(int) count(new Condition(" %s = '%s' ", Field.key, key));
    }

}
