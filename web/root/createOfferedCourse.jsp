<%@page import="common.ResultList"%>
<jsp:include page="../header.jsp"/>
<%@ page import ="java.sql.*, common.DB, java.util.*" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Offer Course - <%=session.getAttribute("User").toString()%></title>
    <script>
        jQuery(function($) {
            $('form').bind('submit', function() {
                $(this).find(':input').removeAttr('disabled');
            });
        });
    </script>
    <script>
        $( document ).ready( function () {
            $(".semester-label").val($("#semester :selected").text());
            $("#semesterID").val($("#semester").val());
        });
    </script>
</head>
<body>
    <div class="container">
        <jsp:include page="../component/semesterAutoComplete.jsp"/>
        <div id="semesterFilterResult">
            <table class="table" id="tblSemesters">
                <thead>
                    <tr>
                        <th>Course Code</th>
                        <th>Course ID</th>
                        <th>Course Name</th>
                        <th>Course Credit Hours</th>
                        <th>Penyelaras</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                    if(request.getParameter("semesterID") != null) {
                    String semesterID = request.getParameter("semesterID");
                    String query = "SELECT co.username, co.course_offered_ID, c.courseCode, c.courseID, c.courseName, c.creditHours FROM course_offered AS co, course AS c WHERE " +
                            "co.courseCode = c.courseCode AND co.courseID = c.courseID AND " +
                            "co.semesterID = " + semesterID;
                    ResultList rs = DB.query(query);
                    while(rs.next()) {
                    %>
                    <tr>
                        <td><%=rs.getString("courseCode")%></td>
                        <td><%=rs.getString("courseID")%></td>
                        <td><%=rs.getString("courseName")%></td>
                        <td><%=rs.getString("creditHours")%></td>
                        <td>
                            <%
                            if(rs.getString("username")!=null && !rs.getString("username").equals("")) {
                                String penyelaras = rs.getString("username");
                                ResultList rs2 = DB.query("SELECT * FROM profile WHERE username='"+penyelaras+"'");
                                rs2.next();
                                out.println(rs2.getString("name"));
                            } else {
                                out.println("No Penyelaras Yet");
                            }
                            %>
                        </td>
                        <td>
                            <a href="<%=request.getContextPath()%>/root/sections.jsp?semesterID=<%=request.getParameter("semesterID")%>&course_offered_ID=<%=rs.getString("course_offered_ID")%>" class="btn btn-primary">View Section</a>
                            <a href="<%=request.getContextPath()%>/DeleteOfferedCourseServlet?course_offered_ID=<%=rs.getString("course_offered_ID")%>" class="btn btn-danger">Delete</a>
                        </td>
                    </tr>
                    <% } } %>
                </tbody>
            </table>
            <% if(request.getParameter("semesterID") != null) {%>
            <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#newCourse">Add New Course</button>
            <div id="newCourse" class="modal fade" role="dialog">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            New Course
                        </div>
                        <form class='form' action="<%=request.getContextPath()%>/CreateOfferedCourseServlet">
                            <div class="modal-body">
                                <label>Semester: </label>
                                <input class="form-control semester-label" disabled>
                                <label>Course Name:</label>
                                <jsp:include page="../component/courseAutoComplete.jsp">
                                    <jsp:param name="selectAction" value="update"/>
                                </jsp:include>
                                <div class="hidden">
                                    <input id="semesterID" name="semesterID">
                                </div> 
                            </div>
                            <div class="modal-footer">
                                <button type="submit" class='btn btn-primary'>New Course</button>
                                <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>                        
                            </div>
                        </form>
                    </div>
                </div>
            </div>
            <% } %>
        </div>
    </div> <!-- /.container -->
</body>
<jsp:include page="../footer.jsp"/>
</html>
