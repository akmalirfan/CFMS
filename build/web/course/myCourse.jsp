<%@page import="common.ResultList"%>
<jsp:include page="../header.jsp"/>
<%@ page import ="java.sql.*, common.DB, java.util.*" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>My Courses</title>
    <script>
        function viewSuperviseCourse (semesterID, course) {
            dataSet = { 
                "semesterID": semesterID,
                "course": course
            };
            var uri = new URI("<%=request.getContextPath()%>/upload/uploadSearch.jsp");
            var query = new URI(uri.search());
            var query = query.setSearch(dataSet);
            window.location.href = uri + query;
        };
    </script>
</head>
<body>
    <div class="container">
        <jsp:include page="../component/semesterAutoComplete.jsp"/>
        <table class="table" id="resultTable"
            data-toggle="table" 
            data-search="true"
            data-pagination="true"
            data-show-toggle="true">
            <thead>
                <tr>
                    <th data-sortable="true">Course Code ID</th>
                    <th data-sortable="true">Course Name</th>
                    <th data-sortable="true">Section No</th>
                    <th data-sortable="true">Penyelaras</th>
                    <th>Upload</th>
                </tr>
            </thead>
            <tbody>
                <%
                String query = "";
                if(request.getParameter("semesterID") != null && !request.getParameter("semesterID").equals("")) {
                String semesterID = request.getParameter("semesterID");
                query = "SELECT * FROM (SELECT semesterID as sID, course_offered_ID AS co_id, username AS penyelaras_id " +
                        "from course_offered) AS co, " +
                        "(SELECT c.courseCode, c.courseID, c.courseName, s.sectionID, s.sectionNO AS sNO, s.course_offered_id AS co_id " +
                        "FROM section_lecturer AS sl, section AS s, course AS c, profile AS p WHERE s.courseCode = c.courseCode AND s.courseID = c.courseID " + 
                        "AND s.sectionID = sl.sectionID AND s.username = p.username AND s.semesterID = " + semesterID + " AND sl.username = '" + session.getAttribute("User") + "') AS mine " +
                        "WHERE co.co_id = mine.co_id";
                } else {
                query = "SELECT * FROM (SELECT semesterID as sID, course_offered_ID AS co_id, username AS penyelaras_id " +
                        "from course_offered) AS co, " +
                        "(SELECT c.courseCode, c.courseID, c.courseName, s.sectionID, s.sectionNO AS sNO, s.course_offered_id AS co_id " +
                        "FROM section_lecturer AS sl, section AS s, course AS c, profile AS p WHERE s.courseCode = c.courseCode AND s.courseID = c.courseID " + 
                        "AND s.sectionID = sl.sectionID AND s.username = p.username AND sl.username = '" + session.getAttribute("User") + "') AS mine " +
                        "WHERE co.co_id = mine.co_id";        
                }
                ResultList rs = DB.query(query);
                while(rs.next()) {
                %>
                <tr>
                    <td><%=rs.getString("courseCode")%> <%=rs.getString("courseID")%></td>
                    <td><%=rs.getString("courseName")%></td>
                    <td><%=rs.getString("sNO")%></td>
                    <td>
                        <% 
                        if(rs.getString("penyelaras_id") == null || rs.getString("penyelaras_id").equals("")) {
                        %>
                        <span class="label label-default">No Penyelaras</span>
                        <%
                        } else if(rs.getString("penyelaras_id").equals(session.getAttribute("User"))) {
                        %>
                        <button type="button" class="btn btn-default" onclick="viewSuperviseCourse(<%=rs.getString("sID")%>, '<%=rs.getString("courseCode")%>/<%=rs.getString("courseID")%>');">Manage Course</button>
                        <%
                        } else {
                            String query2 = "SELECT * FROM profile WHERE username = '" + rs.getString("penyelaras_id") + "'";
                            ResultList rs2 = DB.query(query2);
                            rs2.next();
                            if(rs.getString("name") != null && !rs.getString("name").equals("")) {
                                out.print(rs2.getString("name"));
                            } else {
                                out.print("No Penyelaras Yet");
                            }
                        }
                        %>
                    </td>
                    <td> 
                        <a href = "<%=request.getContextPath()%>/upload/upload.jsp?sectionID=<%=rs.getString("sectionID")%>"> 
                            <button class="btn btn-info" type="button"><i class = "glyphicon glyphicon-upload"></i> View/Upload </button>
                        </a>
                    </td>                    
                </tr>
                <% } %>
            </tbody>
        </table>
    </div> <!-- /.container -->
</body>
<jsp:include page="../footer.jsp"/>
</html>
