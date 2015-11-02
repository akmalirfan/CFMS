/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package AutoComplete;

import common.DB;
import java.util.HashMap;
import java.util.Iterator;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

/**
 *
 * @author Kiwi
 */
public class Select2OptionGenerator {
    
    public static String generate(String query, String display, HashMap<String, String> extra) throws JSONException {
        String options = "";
        JSONArray jsonArray = DB.createJson(query, extra);
        if(jsonArray!=null && jsonArray.length()>0) {
            for (int i = 0; i < jsonArray.length(); i++) {
                String toDisplay = "";
                options += "<option";
                JSONObject obj = jsonArray.getJSONObject(i);
                Iterator<String> keys = obj.keys();
                while(keys.hasNext()){
                    String key = keys.next();
                    if(key.equals(display)) {
                        toDisplay = obj.get(key).toString();
                    }
                    else {
                        String val = obj.get(key).toString();
                        options += " "+key+"=\""+val+"\"";
                    }
                }
                options += ">";
                options += toDisplay;
                options += "</option>";
            }
        }
        else {
            options="<option disabled=\"disabled\">No Result Found</option>";
        }
        return options;
    }
}
