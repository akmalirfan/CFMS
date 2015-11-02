/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package common;

/**
 *
 * @author Ahmad Rafiuddin
 */

public class Page {
    private String glyphIcon;
    private String allowedUser;
    private String fileName;
    private String pageTitle;
    private boolean isLoggedIn;
    private String loggedOutPage;

    public Page(String userType, String fileName, String pageTitle, boolean isLoggedIn, String loggedOutPage) {
        this.allowedUser = userType;
        this.fileName = fileName;
        this.pageTitle = pageTitle;
        this.isLoggedIn = isLoggedIn;
        this.loggedOutPage = loggedOutPage;
    } 
    
    public Page(String userType, String fileName, String pageTitle) {
        this.allowedUser = userType;
        this.fileName = fileName;
        this.pageTitle = pageTitle;
    }
    
    public Page(String glyphIcon, String userType, String fileName, String pageTitle) {
        this.glyphIcon = glyphIcon;
        this.allowedUser = userType;
        this.fileName = fileName;
        this.pageTitle = pageTitle;
    }

    public String getAllowedUser() {
        return allowedUser;
    }

    public void setAllowedUser(String userType) {
        this.allowedUser = userType;
    }

    public String getFileName() {
        return fileName;
    }

    public void setFileName(String fileName) {
        this.fileName = fileName;
    }

    public String getPageTitle() {
        return pageTitle;
    }

    public void setPageTitle(String pageTitle) {
        this.pageTitle = pageTitle;
    }

    public String getGlyphIcon() {
        return glyphIcon;
    }

    public void setGlyphIcon(String glyphIcon) {
        this.glyphIcon = glyphIcon;
    }

    public boolean isIsLoggedIn() {
        return isLoggedIn;
    }

    public void setIsLoggedIn(boolean isLoggedIn) {
        this.isLoggedIn = isLoggedIn;
    }

    public String getLoggedOutPage() {
        return loggedOutPage;
    }

    public void setLoggedOutPage(String loggedOutPage) {
        this.loggedOutPage = loggedOutPage;
    }
    
    public void determineDirection() {
        if (!isLoggedIn) {
            this.pageTitle = this.loggedOutPage;
        }
    }
}
