/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package common;

/**
 *
 * @author Kiwi
 */
public enum ViewPermission {
    LECTURER("Lecturer"),
    PENYELARAS("Penyelaras"),
    KETUA_JABATAN("Ketua Jabatan"),
    PENTADBIR("Pentadbir");
    
    private String label;
    ViewPermission(String label) {
        this.label = label;
    }
    @Override
    public String toString(){
        return label;
    }
}
