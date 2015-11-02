    <%@page import="common.ResultList"%>
<%-- 
    Document   : createSemester
    Created on : Jul 30, 2015, 4:30:28 PM
    Author     : Kiwi
--%>
<jsp:include page="../header.jsp"/>
<%@ page import ="java.sql.*, common.DB" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <script>
            jQuery(function($) {
                $('form').bind('submit', function() {
                    $(this).find(':input').removeAttr('disabled');
                });
            });
        </script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Create Semester - <%=session.getAttribute("User").toString()%></title>
    </head>
    <body>
        <div class="container">
            <h1>Current Running Semester</h1>
            <table class="table" id="semesterList">
                <thead>
                    <tr>
                        <th>Year</th>
                        <th>Semester</th>
                        <th>Courses Offered</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        ResultList rs = DB.query("SELECT * FROM year_semester");
                        int year=0, sem=0;
                        while(rs.next()) {
                            String semester=rs.getString("year") + " / " + rs.getString("semester");
                    %>
                    <tr>
                        <td><%=rs.getString("year")%></td>
                        <td><%=rs.getString("semester")%></td>
                        <td>
                            <a href="<%=request.getContextPath()%>/root/createOfferedCourse.jsp?semesterID=<%=rs.getString("semesterID")%>&semester=<%=semester%>" class="btn btn-primary">View Courses</a>
                            <a href="<%=request.getContextPath()%>/root/sections.jsp?semesterID=<%=rs.getString("semesterID")%>" class="btn btn-primary">View Section</a>
                        </td>
                    </tr>
                    <% 
                        year = Integer.parseInt(rs.getString("year"));
                        sem = Integer.parseInt(rs.getString("semester"));
                        } 
                    %>
                </tbody>
            </table>
            <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#newSemester">Add New Semester</button>
            <div id="newSemester" class="modal fade" role="dialog">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            Are you sure you want to create a new Semester?
                        </div>
                        <form class='form-horizontal' action="<%=request.getContextPath()%>/CreateSemesterServlet">
                            <div class="modal-body">
                                <%
                                    if(sem != 3) {
                                        ++sem;
                                    }
                                    else {
                                        sem = 1;
                                        year += 10001;
                                    }
                                 %>
                                <label>Year: </label>
                                <input class="form-control" name="year" placeholder="Year" value=<%=year%> disabled>
                                <label>Semester: </label>
                                <input class="form-control" name="semester" placeholder="Semester" value=<%=sem%> disabled>
                                <span class="label label-danger">The change is permanent!</span>
                            </div>
                            <div class="modal-footer">
                                <button type="submit" class='btn btn-primary'>Confirm</button>
                                <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>                        
                            </div>
                        </form>
                    </div>
                </div>
            </div>    
        </div>
    </body>
    <jsp:include page="../footer.jsp"/>
</html>
