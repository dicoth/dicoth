module app.component.system.helper.Utils;
import std.digest.sha;
import hunt.framework;

import hunt.entity.domain;
import hunt.util.Serialize;

import std.conv;
import std.json;
import std.string;

static JSONValue pageToJson(T)(Page!T pageObj)
{
	JSONValue page;
	int cur = pageObj.getNumber();
	page["cur"] = cur;
	page["total"] = pageObj.getTotalElements();
	page["totalPages"] = pageObj.getTotalPages();
	page["size"] = pageObj.getSize();
	page["prev"] = cur - 1;
	page["next"] = cur + 1;
	JSONValue[] data;
	foreach(p ; pageObj.getContent())
	{
		data ~= toJSON(p);
		
	}
	page["data"] = JSONValue(data);
	return page;
}


static int initInt(string paramName, int initValue = 1, string reqType = "POST"){
    int resNum;
    if(paramName && reqType){
        string param;
        if(reqType == "POST"){
            param = request.post(paramName, initValue.to!string).replace(" ", "");
        }else{
            param = request.get(paramName, initValue.to!string).replace(" ", "");
        }
        resNum = isNumeric(param) ? to!int(param) : initValue;
    }
    return resNum;
}

class Utils
{
public:
    static string fileExt(string filename)
    {
        import std.string;

        auto sections = split(filename, '.');
        if (sections.length > 1)
            return sections[$ - 1];
        return string.init;
    }

public:
    static T[] getCheckbox(T)(string[string] requestParams, string keyword)
    {
        T[] resultIds;

        foreach(key, value; requestParams)
        {
            if(indexOf(key, keyword) != -1)
            {
                resultIds ~= value.to!T();
            }
        }
        return resultIds;
    }


}
