<%@page import="common.ResultList"%>
<jsp:include page="../header.jsp"/>
<%@ page import ="java.sql.*, common.DB, java.util.*" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Offered Courses</title>
    <script>
        var semester = [];
        $.getJSON("<%=request.getContextPath()%>/ListSemesterServlet", {
            label: "[year] / [semester]",
            value: "[year] / [semester]"
        },
        function( json ) {
            var keys = Object.keys(json);
            keys.forEach(function(key){
                semester.push(json[key]);
            });
        });
        jQuery(function(){
            $("#semester").autocomplete( {
                source: semester,
                select: function( event, ui ) {
                    dataSet = { 
                        "semesterID":ui.item.semesterID, 
                        "semester":ui.item.label 
                    };
                    var uri = new URI(window.location.href);
                    var query = new URI(uri.search());
                    var query = query.setSearch(dataSet);
                    var uri = uri.pathname();
                    var newQueryUrl = uri + query;
                    window.location.href = uri + query;
                }
            });
        });
    </script>
    <script>
        <%if(request.getParameter("semesterID") != null) { %>
        $( document ).ready( function () {
            $("#semesterID").val("<%=request.getParameter("semesterID")%>");
            $("#semester").val("<%=request.getParameter("semester")%>");
            $(".semester-label").val("<%=request.getParameter("semester")%>");
        });
        <% } %>
    </script>
</head>
<body>
    <div class="container">
        <input class="form-control" id="semester" placeholder="Choose Semester">
        <table class="table" id="tblSemesters"
            data-toggle="table" 
            data-search="true"
            data-pagination="true"
            data-show-toggle="true">
            <thead>
                <tr>
                    <th data-sortable="true">Course Code</th>
                    <th data-sortable="true">Course ID</th>
                    <th data-sortable="true">Course Name</th>
                    <th data-sortable="true">Course Credit Hours</th>
                    <th data-sortable="true">Penyelaras</th>
                </tr>
            </thead>
            <tbody>
                <%
                if(request.getParameter("semesterID") != null) {
                String semesterID = request.getParameter("semesterID");
                String query = "SELECT co.course_offered_ID, c.courseCode, c.courseID, c.courseName, c.creditHours, p.name, p.username FROM " + 
                        "course_offered AS co, course AS c, profile AS p WHERE " +
                        "co.courseCode = c.courseCode AND co.courseID = c.courseID AND " +
                        "co.username = p.username AND co.semesterID = " + semesterID;
                ResultList rs = DB.query(query);
                while(rs.next()) {
                %>
                <tr>
                    <td><%=rs.getString("courseCode")%></td>
                    <td><%=rs.getString("courseID")%></td>
                    <td><%=rs.getString("courseName")%></td>
                    <td><%=rs.getString("creditHours")%></td>
                    <td><%=rs.getString("name")%></td>
                </tr>
                <% } } %>
                <%
                if(request.getParameter("semesterID") != null) {
                String semesterID = request.getParameter("semesterID");
                String query = "SELECT co.course_offered_ID, c.courseCode, c.courseID, c.courseName, c.creditHours FROM course_offered AS co, course AS c WHERE " +
                        "co.courseCode = c.courseCode AND co.courseID = c.courseID AND " +
                        "co.username IS NULL AND co.semesterID = " + semesterID;
                ResultList rs = DB.query(query);
                while(rs.next()) {
                %>
                <tr>
                    <td><%=rs.getString("courseCode")%></td>
                    <td><%=rs.getString("courseID")%></td>
                    <td><%=rs.getString("courseName")%></td>
                    <td><%=rs.getString("creditHours")%></td>
                    <td> - </td>
                </tr>
                <% } } %>
            </tbody>
        </table>
    </div> <!-- /.container -->
</body>
<jsp:include page="../footer.jsp"/>
</html>