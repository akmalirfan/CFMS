<%@page import="common.ResultList"%>
<%@page import="common.ViewPermission"%>
<%@page import="common.DB"%>
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
    
    // add pages to arraylist
    // Pages constructor: <userType> <fileName> <pageTitle>
    pages.add(new Page("all", request.getContextPath() + "/index.jsp", "Home"));
    
    
    pages.add(new Page("root", request.getContextPath() + "/root/viewLecturers.jsp", "Lecturers"));
    pages.add(new Page("root", request.getContextPath() + "/root/createSemester.jsp", "Semester"));

    // Below commented out because already present in the form of dropdown
    //pages.add(new Page("root", "viewCourse.jsp", "View Courses"));
    //pages.add(new Page("root", "createOfferedCourse.jsp", "Current Offered Courses"));
    pages.add(new Page("root", request.getContextPath() + "/root/sections.jsp", "Sections"));
    pages.add(new Page("root", request.getContextPath() + "/root/viewChecklist.jsp", "Checklists"));
    pages.add(new Page("root", request.getContextPath() + "/upload/uploadSearch.jsp", "Manage Upload"));
    
    
    pages.add(new Page("lecturer", request.getContextPath() + "/course/myCourse.jsp", "My Courses"));
    pages.add(new Page("lecturer", request.getContextPath() + "/upload/uploadSearch.jsp", "Manage Upload"));
    //pages.add(new Page("lecturer", request.getContextPath() + "/user/lecturerProfile.jsp", "Profile"));

    String viewPermissionAttribute = "Guest";
    
    if (session.getAttribute("viewPermission") != null) {
        ViewPermission a = ViewPermission.valueOf(session.getAttribute("viewPermission").toString());
        viewPermissionAttribute = a.toString();
    }
%>

<!DOCTYPE html>

<link rel="stylesheet" href="<%=request.getContextPath()%>/css/bootstrap.min.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/bootstrap-theme.min.css">
<link rel="icon" 
      type="image/ico" 
      href="<%=request.getContextPath()%>/img/favicon.ico">

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
</style>

<link rel="stylesheet" href="<%=request.getContextPath()%>/css/auto-complete.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/bootstrap-table.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/select2.min.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/select2-bootstrap.min.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/footer-style.css">
<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/jquery-2.1.4.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/jquery-ui-1.9.2.custom.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/jquery.URI.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/bootstrap.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/bootstrap-table.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/select2.min.js"></script>



<!---// load the mcDropdown CSS stylesheet //--->


<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<div class="page-header">
    <div class="container-fluid" style="margin-bottom: 20px;">
        <div class="col-xs-1 media-left">
            <img class="img-responsive media-object" src="<%=request.getContextPath()%>/img/LambangMalaysia.png" alt="Malaysian Coat of Arms">						
        </div>

        <div class="col-xs-2 media-left" >
            <a href="http://www.utm.my">
                <img class="img-responsive media-object" src="<%=request.getContextPath()%>/img/LogoUTM.png" alt="UTM Logo"/>
            </a>
        </div>

        <div class="col-xs-offset-1 col-xs-6">
            <div style="margin-top: -25px;">
                <h1>Course File Management System<br>
                    <small class="website-title">Faculty Of Computing</small>
                </h1>
                <div style="margin-top:-5px;opacity:0.8;margin-left:-2px;">
                    <img alt="UTM Tagline" height="20" src="<%=request.getContextPath()%>/img/tagline-bi.png" />
                </div>
            </div>
        </div>

        <div class="col-xs-2">
            <span style="margin:0px;float:right;margin-top:auto;">
                <img width=20 src="http://www.utm.my/dev/2014/social-media-icon/mobile-icon(small).jpg" alt="Mobile" onClick="alert('This website can be viewed in mobile device')">
                <a target="_blank" href="http://www.facebook.com/univteknologimalaysia"><img width=24 src="http://www.utm.my/dev/2014/social-media-icon/iconmonstr-facebook-2-icon.svg" alt="Facebook"></a>
                <a target="_blank" href="https://twitter.com/utm_my"><img width=24 src="http://www.utm.my/dev/2014/social-media-icon/iconmonstr-twitter-2-icon.svg" alt="Twitter"></a>
                <a target="_blank" href="http://www.youtube.com/utmskudaimalaysia"><img width=24 src="http://www.utm.my/dev/2014/social-media-icon/iconmonstr-youtube-2-icon.svg" alt="YouTube"></a>
                <a target="_blank" href="http://instagram.com/utmofficial"><img width=24 src="http://www.utm.my/dev/2014/social-media-icon/iconmonstr-instagram-2-icon.svg" alt="Instagram"></a>
                <a target="_blank" href="http://www.pinterest.com/utmmy/"><img width=24 src="http://www.utm.my/dev/2014/social-media-icon/iconmonstr-pinterest-2-icon.svg" alt="Pinterest"></a>
            </span>
        </div>
    </div>
</div>

<div class="container">

    <nav class="navbar navbar-default">
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
                <ul class="nav navbar-nav">
                    
                    <%  // Full credit to Lo King Wei for below piece of code
                        for (int i = 0; i < pages.size(); ++i) {
                            Page p = pages.get(i);
                            
                            // Determine if user is logged in
                            if (p.getAllowedUser().equals(session.getAttribute("userType"))) {
                                isLoggedIn = true;
                            }
                            
                            if (p.getAllowedUser().equals(session.getAttribute("userType")) || p.getAllowedUser().equals("all")) {
                                if (p.getFileName().contains(currentPageLoaded)) {
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
                                            Courses<span class="caret"></span>
                                        </a>
                                        <ul class ="dropdown-menu">
                                            <li><a href="<%=request.getContextPath()%>/root/viewCourses.jsp">All Courses</a></li>
                                            <li><a href="<%=request.getContextPath()%>/root/createOfferedCourse.jsp">Offered Course</a></li>
                                        </ul>
                                    </li>
                    <%
                        }
                    %>
                </ul>
                
                <% if (isLoggedIn) { %>
                    <ul class="nav navbar-nav navbar-right">
                        
                        <!--- Super Admin Component -->
                        <% if (session.getAttribute("isSuper") != null && session.getAttribute("isSuper").equals("true")) { %>
                            <li class="dropdown">
                                <a class="dropdown-toggle" data-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="false">
                                    Role: <%=session.getAttribute("userType")%><span class="caret"></span>
                                </a>
                                <ul class="dropdown-menu">
                                    <li><a href="<%=request.getContextPath()%>/ChangeUserRole?userType=root">Admin</a></li>
                                    <li><a href="<%=request.getContextPath()%>/ChangeUserRole?userType=lecturer">Lecturer</a></li>
                                </ul>
                            </li>
                            <% if(session.getAttribute("userType").equals("lecturer")) {
                                ResultList rs = DB.query("SELECT * FROM user, profile WHERE user.username = profile.username AND user.usertype = 'lecturer'");
                            %>
                            <li class="dropdown">
                                <a class="dropdown-toggle" data-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="false"> Lecturer: <%=session.getAttribute("name")%> <span class="caret"></span></a>
                                <ul class="dropdown-menu">
                                    <% while(rs.next()) { %>
                                    <li><a href="<%=request.getContextPath()%>/ChangeUsername?username=<%=rs.getString("username")%>&name=<%=rs.getString("name")%>"><%=rs.getString("name")%></a></li>
                                    <% } %>
                                </ul>
                            </li>
                            <li class="dropdown">
                                <a class="dropdown-toggle" data-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="false"> Permission: <%=session.getAttribute("viewPermission")%> <span class="caret"></span></a>
                                <ul class="dropdown-menu">
                                    <% for (ViewPermission permission : ViewPermission.values()) { %>
                                    <li><a href="<%=request.getContextPath()%>/ChangeViewPermission?permission=<%=permission.name()%>"><%=permission%></a></li>
                                    <% } %>
                                </ul>
                            </li>
                            <% } %>
                        <% } %>
                        <!--- Super Admin Component END -->
                        
                        <% if (session.getAttribute("viewPermission") != null) { %>
                        <li class="dropdown">
                            <a class="dropdown-toggle" data-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="false">
                                <span class="glyphicon glyphicon-user" aria-hidden="true" style="padding-right: 5px"></span>
                                <%=session.getAttribute("name").toString()%>
                                <span class="caret"></span>
                            </a>
                            <ul class="dropdown-menu">
                                <li><a href="#">Viewing as: <%=viewPermissionAttribute%></a></li>
                                <li role="separator" class="divider"></li>
                                
                                <li>
                                    <a href="<%=request.getContextPath()%>/LogoutServlet">
                                        <span class="glyphicon glyphicon-off" style="padding-right: 10px;"></span>Log Out
                                    </a>
                                </li>
                            </ul>
                        </li>
                        <% } %>
                    </ul>
                <% } %>

            </div>
        </div>
    </nav>

    <!--
    <ol class="breadcrumb" style="margin-top: -20px;">
        <li><a href="#">Home</a></li>
        <li><a href="#">Library</a></li>
        <li class="active">Data</li>
    </ol>
    -->
</div>
