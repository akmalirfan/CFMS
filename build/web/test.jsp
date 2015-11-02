<%@page import="java.util.ArrayList, common.Page" %>
<%
    // HEADER PAGE TO BE INCLUDED IN ALL PAGES
    // FOR AUTHENTICATION CHECK, USE auth.jsp
    //
    // Sample Usage:
    // In a page where you want to include this file, add
    // <jsp:include page="../header.jsp"/> if inside one folder in and
    // <jsp:include page="header.jsp"/> if in the same directory as this file
    //
    // MAKE SURE TO INCLUDE THIS FILE BEFORE YOUR 
    // <div class="container"></div> TAGS
    // 
    
    // Example output: index.jsp
    String currentPageNameWithSlash = request.getServletPath();
    String currentPageLoaded = currentPageNameWithSlash.substring(currentPageNameWithSlash.lastIndexOf("/")+1); 
    
    boolean isLoggedIn = false;
    
    if (session.getAttribute("User") != null || session.getAttribute("userType") != null)
        isLoggedIn = true;
    
    // PAGES FOR ALL:
    // - index.jsp
    // 
    // PAGES FOR LOGGED IN USERS:
    // - home.jsp
    // - viewCourses.jsp
    // 
    // PAGES FOR ROOT ONLY:
    // - viewLecturer.jsp
    // - createSemester.jsp
    // - viewCourse.jsp
    // - createOfferedCourse.jsp
    // - createSection.jsp
    //
    // PAGES FOR ADMIN ONLY:
    // - viewLecturers.jsp
    //
    // PAGES FOR LECTURER ONLY:
    // - section.jsp (Upload)
    
    ArrayList<Page> pages = new ArrayList();
    
    // Pages constructor:   public Page(String userType, String fileName, String pageTitle)
    //                      public Page(String userType, String fileName, String pageTitle, boolean isLoggedIn, String loggedOutPage)
    //                      ^ if logged in, will direct to pageTitle, else, will direct to loggedOutPage
    //                      public Page(String glyphIcon, String userType, String fileName, String pageTitle)
        
    // adding pages to arraylist
    pages.add(new Page("all", "home.jsp", "Home", false, "index.jsp"));
    
    
    pages.add(new Page("root", "viewLecturers.jsp", "View Lecturers"));
    pages.add(new Page("root", "createSemester.jsp", "Semester"));

    // Below commented out because already present in the form of dropdown
    //pages.add(new Page("root", "viewCourse.jsp", "View Courses"));
    //pages.add(new Page("root", "createOfferedCourse.jsp", "Current Offered Courses"));
    pages.add(new Page("root", "createSection.jsp", "Create Section"));
    
    pages.add(new Page("admin", "viewCourses.jsp", "Courses"));
    pages.add(new Page("admin", "viewLecturers.jsp", "View Lecturers"));
    
    pages.add(new Page("lecturer", "viewCourses.jsp", "Courses"));
    pages.add(new Page("lecturer", "createSection.jsp", "Upload"));
    
%>

<!DOCTYPE html>

<link rel="stylesheet" href="<%=request.getContextPath()%>/css/bootstrap.min.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/bootstrap-theme.min.css">

<style>
    .website-title {
        text-transform: uppercase;
        font-size: 19px;
        line-height: 19px;
        font-family: Arial;
        font-weight: bold;
        position: relative;
        margin-top: 0px;
        padding-bottom: 6px;
        top: 0px !important;
        border-bottom: 0px;
        color: rgb(51, 51, 51);
    }
    
    ul.dropdown-menu > li span.glyphicon {
        width: 16px;
    }
</style>

<link rel="stylesheet" href="<%=request.getContextPath()%>/css/auto-complete.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/bootstrap-table.css">
<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/jquery-2.1.4.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/jquery-ui-1.9.2.custom.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/jquery.URI.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/bootstrap-table.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/bootstrap.min.js"></script>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<div class="page-header">
    <div class="container-fluid" style="margin-bottom:20px;">
        <div class="col-xs-1">
            <img class="img-responsive media-object" src="<%=request.getContextPath()%>/img/LambangMalaysia.png" alt="Malaysian Coat of Arms">						
        </div>

        <div class="col-xs-2" >
            <a href="http://www.utm.my">
                <img class="img-responsive media-object" src="<%=request.getContextPath()%>/img/LogoUTM.png" alt="UTM Logo"/>
            </a>
        </div>

        <div class="col-xs-offset-1 col-xs-4">
            <div class="row" style="margin-top: -20px;">
                <h1>Course File Management System</h1>
            </div>
            <div class="row">
                <small class="website-title">Universiti Teknologi Malaysia</small>
            </div>
            <div class="row">
                <img alt="UTM Tagline" height="20" src="http://cdn.utm.my/wp-content/themes/enterprise/images-2014/tagline-bi.png" />
            </div>
        </div>

        <div class="col-xs-4">
            <div class="pull-right">
                <div class="row">
                    <img width=20 src="http://www.utm.my/dev/2014/social-media-icon/mobile-icon(small).jpg" alt="Mobile" onClick="alert('This website can be viewed in mobile device')">
                    <a target="_blank" href="http://www.facebook.com/univteknologimalaysia"><img width=24 src="http://www.utm.my/dev/2014/social-media-icon/iconmonstr-facebook-2-icon.svg" alt="Facebook"></a>
                    <a target="_blank" href="https://twitter.com/utm_my"><img width=24 src="http://www.utm.my/dev/2014/social-media-icon/iconmonstr-twitter-2-icon.svg" alt="Twitter"></a>
                    <a target="_blank" href="http://www.youtube.com/utmskudaimalaysia"><img width=24 src="http://www.utm.my/dev/2014/social-media-icon/iconmonstr-youtube-2-icon.svg" alt="YouTube"></a>
                    <a target="_blank" href="http://instagram.com/utmofficial"><img width=24 src="http://www.utm.my/dev/2014/social-media-icon/iconmonstr-instagram-2-icon.svg" alt="Instagram"></a>
                    <a target="_blank" href="http://www.pinterest.com/utmmy/"><img width=24 src="http://www.utm.my/dev/2014/social-media-icon/iconmonstr-pinterest-2-icon.svg" alt="Pinterest"></a>
                </div>
                
                <div class="row pull-right" style="margin-top: 30px;">
                    <div class="btn-group">
                        <button type="button" class="btn btn-primary dropdown-toggle" data-toggle="dropdown" 
                                <% if (!isLoggedIn) { out.println("disabled=\"disabled\""); } %>aria-haspopup="true" aria-expanded="false">
                            <span class="glyphicon glyphicon-user" aria-hidden="true" style="padding-right:5px;"></span>
                            <%
                                if (session.getAttribute("User") != null) {
                                    out.println(session.getAttribute("User"));
                                } else {
                                    out.println("Guest");
                                }
                                
                                if (isLoggedIn) {
                            %>
                                <span class="caret"></span>
                            <%
                                }
                            %>
                        </button>
                        
                        <%
                            if (isLoggedIn) {
                        %>
                        <ul class="dropdown-menu pull-right">
                            <li><a href="#"><span class="glyphicon glyphicon-edit" aria-hidden="true"></span> Profile</a></li>
                            <li><a href="#"><span class="glyphicon glyphicon-envelope" aria-hidden="true"></span> Messages</a></li>
                            <li><a href="#"><span class="glyphicon glyphicon-folder-open" aria-hidden="true"></span> My Files</a></li>
                            <li><a href="#"><span class="glyphicon glyphicon-wrench" aria-hidden="true"></span> Settings</a></li>
                            <li role="separator" class="divider"></li>
                            <li>
                                <a href="<%=request.getContextPath()%>/logoutAction.jsp">
                                    <span class="glyphicon glyphicon-off" aria-hidden="true"></span> Log Out
                                </a>
                            </li>
                        </ul>
                        <%
                            }
                        %>
                        
                    </div>
                </div>
                
            </div>
            
            
            
        </div> <!-- right side of header -->
            
    </div> <!-- /.container-fluid -->
</div>

<div class="container-fluid">

    <nav class="nav nav-tabs">
        <div class="container-fluid">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#utm-cfms-navbar-collapse-1" aria-expanded="false">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
            </div> <!-- /.navbar-header -->

            <div class="collapse navbar-collapse" id="utm-cfms-navbar-collapse-1">
                <ul class="nav nav-tabs nav-justified">
                    
                    <%  // Full credit to Lo King Wei for below piece of code
                        for (int i = 0; i < pages.size(); ++i) {
                            Page p = pages.get(i);
                            
                            // Determine if user is logged in
                            if (p.getAllowedUser().equals(session.getAttribute("userType"))) {
                                isLoggedIn = true;
                            }
                            
                            if (p.getAllowedUser().equals(session.getAttribute("userType")) || p.getAllowedUser().equals("all")) {
                                if (currentPageLoaded.equals(p.getFileName())) {
                    %>
                                    <li class="active"><a href="<%=p.getFileName()%>"><%=p.getPageTitle()%> <span class="sr-only">(current)</span></a></li>
                    <%  
                                } else { 
                    %>
                                    <li><a href="<%=p.getFileName()%>"><%=p.getPageTitle()%></a></li>
                    <%
                                } 
                            }
                        }
                    %>
                    
                    <%
                        if (session.getAttribute("userType") != null && session.getAttribute("userType").equals("root")) {
                    %>
                            <li class="dropdown">
                                <a class="dropdown-toggle" data-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="false">
                                    Course<span class="caret"></span>
                                </a>
                                <ul class="dropdown-menu">
                                    <li><a href="viewCourses.jsp">View Courses</a></li>
                                    <li><a href="createOfferedCourse.jsp">Current Offered Courses</a></li>
                                </ul>
                            </li>
                    <%
                        }
                    %>
                </ul>
                
                <% if (isLoggedIn) { %>
                    <ul class="nav navbar-nav navbar-right">
                        
                        <% if (session.getAttribute("isSuper") != null && session.getAttribute("isSuper").equals("true")) { %>
                            <li class="dropdown">
                                <a class="dropdown-toggle" data-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="false">
                                    Change User<span class="caret"></span>
                                </a>
                                <ul class="dropdown-menu">
                                    <li><a href="<%=request.getContextPath()%>/ChangeUserRole?userType=root">Admin</a></li>
                                    <li><a href="<%=request.getContextPath()%>/ChangeUserRole?userType=admin">Pentadbir</a></li>
                                    <li><a href="<%=request.getContextPath()%>/ChangeUserRole?userType=lecturer">Lecturer</a></li>
                                </ul>
                            </li>
                        <% } %>
                        
                    </ul>
                <% } %>
            </div>
        </div>
    </nav>

    <div class="container-fluid">
    </div>
    <!-- Breadcrumbs, potential implementation
    <ol class="breadcrumb">
        <li><a href="#">Home</a></li>
        <li><a href="#">Library</a></li>
        <li class="active">Data</li>
    </ol>
    -->

</div>