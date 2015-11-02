<%@page import="common.ResultList"%>
<jsp:include page="../header.jsp"/>
<%@ page import ="java.sql.*, common.DB" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>View Lecturers - <%=session.getAttribute("User").toString()%></title>
</head>
<body>
    <div class="container">
                
        
      <table class="table">
        <caption>List of Lecturers</caption>
        <thead>
            <tr>
                <th>Username</th>
                <th>Name</th>
                <th>Email Address</th>
                <th>Phone Number</th>
                <th>Status</th>
                <th>Permission</th>
                <th></th>
            </tr>
        </thead>
        <tbody>
        <%
            String query1 = "SELECT * FROM department";
            ResultList rs1 = DB.query(query1);
            while(rs1.next()) {
        %>
        <tr><td><b>Dept. of <%=rs1.getString("department")%></b></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>
            <%
                String query2 = "SELECT * FROM profile, user WHERE user.username = profile.username AND user.usertype = 'lecturer' AND profile.departmentID="+rs1.getString("departmentID");
                ResultList rs2 = DB.query(query2);   
                while(rs2.next()) {
            %>
            <tr>
                <td><%=rs2.getString("username") %></td>
                <td><%=rs2.getString("name") %></td>
                <td><%=rs2.getString("emailAdd") %></td>
                <td><%=rs2.getString("phoneNo") %></td>
                <td><%=rs2.getString("status") %></td>
                <td><%=rs2.getString("viewPermission") %></td>
                <td><a href="updateLecturer.jsp?username=<%=rs2.getString("username")%>"><button class="btn btn-primary btn-xs">Update</button></a>
                <a href="<%=request.getContextPath()%>/deleteLecturer?username=<%=rs2.getString("username")%>"><button class="btn btn-danger btn-xs" onclick= "return confirm('Are you sure you want to continue')">Delete</button></a></td>
            </tr>
            <% } %>
        <% } %>
        </tbody>
      </table>
                
            <p>
   <a role="button" class="btn btn-primary" href="addLecturer.jsp">
      Add
   </a>
</p>
    </div> <!-- /.container -->
</body>
<jsp:include page="../footer.jsp"/>
</html>
