<jsp:include page="header.jsp"/>
<%
    String userType = "Guest";
    boolean isLoggedIn = false;
    if (session.getAttribute("userType") != null) {
        userType = (String) session.getAttribute("userType");
        isLoggedIn = true;
    } 
    
    boolean invalidPassword = false;
    
    if (session.getAttribute("Error") != null) {
        if (session.getAttribute("Error").equals("Invalid password.")) {
            invalidPassword = true;
        }
    }
%>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>UTM Course File Management System</title>
</head>
<body>
    <div class="container">
        <%
            String access_error = "Access Error";
            if (session.getAttribute(access_error) != null) { // If there is an error during login
        %>
                <div class="alert alert-danger" role="alert">
                    <span class="glyphicon glyphicon-remove" aria-hidden="true" style="padding-right: 10px"></span>
                    <strong><%=session.getAttribute(access_error) %></strong>
                </div>
        <%
            session.removeAttribute(access_error);
            }
        %>
        
        <div class= "<% if (!isLoggedIn) out.println("col-xs-8"); %>">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title"><strong>What is Course File?</strong></h3>
                </div>
                    <div class="panel-body">
                    <p>Course files are printed and given to every student at the beginning of each semester. This practice is helping the teachers and students enormously.
                        The course file contains</p>
                    <ul>
                        <li>Syllabus</li>
                        <li>Lecturer Schedules</li>
                        <li>Depth of study defined by learning objectives of the subject, Short answer questions (40 per chapter) and long answer questions (20 per chapter).</li>
                    </ul>

                    <p>With this, the students can come prepared for the topic to be discussed which results in Active Learning. The students also can understand the depth upto which the subject must be studied with the help of questions given in the course file.</p>

                    <p>This is also helping new teacher to understand the depth upto which the subject has to be taught.</p>
                </div>
            </div>
        </div>
        
        <%
            if (!isLoggedIn) {
        %>
            <div class="col-xs-4">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h3 class="panel-title"><strong>Login</strong></h3>
                    </div>
                    <div class="panel-body">

                        <form class="form-horizontal" method="post" action="<%=request.getContextPath()%>/LoginServlet">
                            <div class="form-group">
                                <label for="username" class="control-label col-xs-4">Username</label>
                                <div class="col-xs-8">
                                    <input type="text" class="form-control" name="inputUsername" placeholder="Username" required>
                                </div>
                            </div>
                            <div class="form-group <% if (invalidPassword) out.println("has-error"); %>">
                                <label for="inputPassword" class="control-label col-xs-4">Password</label>
                                <div class="col-xs-8">
                                    <input type="password" class="form-control" name="inputPassword" placeholder="Password" required>
                                </div>
                            </div>

                            <div class="form-group">
                                <div class="col-xs-offset-8 col-xs-4">
                                    <button type="submit" class="btn btn-primary">Login</button>
                                </div>
                            </div>
                        </form>
                    </div> <!-- /.panel-body -->
                </div> <!-- /.panel .panel-default -->


                <%
                    String login_error = "Login Error";
                    if (session.getAttribute(login_error) != null) { // If there is an error during login
                %>
                        <div class="alert alert-danger" role="alert">
                            <span class="glyphicon glyphicon-remove" aria-hidden="true" style="padding-right: 10px"></span>
                            <strong><%=session.getAttribute(login_error) %></strong>
                        </div>
                <%
                    session.removeAttribute(login_error);
                    }
                %>
            </div>
        <%
            }
        %>
                
    </div> <!-- /.container -->
</body>
<jsp:include page="footer.jsp"/>
</html>
