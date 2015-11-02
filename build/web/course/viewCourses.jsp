<%@page import="common.ResultList"%>
<jsp:include page="../header.jsp"/>
<%@ page import ="java.sql.*, common.DB" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>View Courses</title>
</head>
<body>

<%
   ResultList rs = DB.query("SELECT * FROM course");
%>

    <div class="container">
      <table 
          data-toggle="table" 
          data-search="true"
          data-pagination="true"
          data-show-toggle="true">
        <thead>
            <tr>
                <th data-sortable="true" data-field="courseCode">Course Code</th>
                <th data-sortable="true" data-field="courseName">Course Name</th>
                <th data-field="courseHours">Credit Hours</th>
            </tr>
        </thead>
        <tbody>
        <%while(rs.next()){ %>
            <tr>
                <td><%=rs.getString("courseCode") %> <%=rs.getString("courseID") %></td>
                <td><%=rs.getString("courseName") %></td>
                <td><%=rs.getString("creditHours") %></td>
            </tr>
        <% } %>
        </tbody>
      </table>
    </div> <!-- /.container -->
</body>
<jsp:include page="../footer.jsp"/>
</html>