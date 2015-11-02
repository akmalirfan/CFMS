/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package common;

import java.util.*;
import java.util.Map.Entry;

/**
 *
 * @author Kiwi
 * @param <T> = class
 */
public class ResultList {
    int pos;
    ArrayList<Map> table;
    
    ResultList() { pos=0; }
    ResultList(ArrayList<Map> table) {
        this.table = table;
        pos = 0;
    }
    
    public String getString(String str) {
        String result;
        Map row = table.get(pos);
        result = (String)row.get(str);
        return result;
    }
    
    public boolean next() {
        ++pos;
        if(pos >= table.size()){
            --pos;
            return false;
        }
        else {
            return true;
        }
    }
    
    public void dump() {
        int num = 0;
        for(Map row: table) {
            Iterator entries = row.entrySet().iterator();
            System.out.println("===== Row "+ num + " =====");
            while (entries.hasNext()) {
                Entry thisEntry = (Entry) entries.next();
                String key = (String) thisEntry.getKey();
                String value = (String) thisEntry.getValue();
                System.out.println(key + " : " + value);
            }
            System.out.println("===== Row "+ num + " End =====");
            ++num;
        }
    }
}
