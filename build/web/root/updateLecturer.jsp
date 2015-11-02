<%@page import="common.ResultList"%>
<%@page import="common.ViewPermission"%>
<jsp:include page="../header.jsp"/>
<%@ page import ="java.sql.*, common.DB" %>
<%
	String username = request.getParameter("username");

	ResultList rs = DB.query("SELECT * FROM user, profile, department WHERE profile.username= '"+username+"' AND profile.departmentID=department.departmentID AND user.username = profile.username");
        rs.next();
%>

<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Update Lecturer Profile - <%=session.getAttribute("User").toString()%></title>
</head>

<body>
    <div class="container">
        
        <form class="form-horizontal" method="post" action="<%=request.getContextPath()%>/updateLecturerDB">
            <div class="form-group" hidden>
            <label for="username" class="control-label col-xs-4">Username</label>
                <div class="col-xs-8">
                    <input type="text" class="form-control" name="username" value="<%=rs.getString("username") %>">
                </div>
            </div>

            <div class="form-group">
                <label for="name" class="control-label col-xs-4">Name</label>
                <div class="col-xs-8">
                    <input type="text" class="form-control" name="name" value="<%=rs.getString("name") %>">
                </div>
            </div>

            <div class="form-group">
                <label for="password" class="control-label col-xs-4">Email Address</label>
                <div class="col-xs-8">
                    <input type="text" class="form-control" name="emailAdd" value="<%=rs.getString("emailAdd") %>">
                </div>
            </div>

            <div class="form-group">
                <label for="phoneNo" class="control-label col-xs-4">Phone Number</label>
                <div class="col-xs-8">
                    <input type="text" class="form-control" name="phoneNo" value="<%=rs.getString("phoneNo") %>">
                </div>
            </div>

            <div class="form-group">
                <label for="department" class="control-label col-xs-4">Department</label>
                <div class="radio col-xs-8">
                <% 
                    String query = "SELECT * FROM department";
                    ResultList rs2 = DB.query(query);
                    while(rs2.next()) {
                        if(rs.getString("departmentID").equals(rs2.getString("departmentID"))) {
                %>
                            <label class="radio-inline"><input checked="checked" type="radio" name="department" value="<%=rs2.getString("departmentID")%>"><%=rs2.getString("department")%></label>
                        <% } else { %>
                            <label class="radio-inline"><input type="radio" name="department" value="<%=rs2.getString("departmentID")%>"><%=rs2.getString("department")%></label>
                        <% } %>
                <% } %>
                </div>
            </div>

            <div class="form-group">
                <label for="status" class="control-label col-xs-4">Status</label>
                <div class="radio col-xs-8">
                <%
                    String[] statuses = {"Active", "Inactive"};
                    for(String status: statuses) {
                        if(status.equals(rs.getString("status"))) {
                        %>
                            <label class="radio-inline"><input checked="checked" type="radio" name="status" value="<%=status%>"><%=status%></label>
                        <% } else { %>
                            <label class="radio-inline"><input type="radio" name="status" value="<%=status%>"><%=status%></label>
                        <% } %>
                    <% } %>
                </div>
            </div>

            <div class="form-group">
                <label for="view" class="control-label col-xs-4">View Permission</label>					 
                <div class="radio col-xs-8">
                    <% 
                    for(ViewPermission vp: ViewPermission.values()) {
                        ViewPermission userPermission = ViewPermission.valueOf(rs.getString("viewPermission"));
                        if(userPermission == vp) {
                        %>
                            <label class="radio-inline"><input checked="checked" type="radio" name="view" value="<%=vp.name()%>"><%=vp.toString()%></label>
                        <% } else { %>
                            <label class="radio-inline"><input type="radio" name="view" value="<%=vp.name()%>"><%=vp.toString()%></label>
                        <% } %>
                    <% } %>
                </div>
            </div>

            <div class="form-group">
                <div class="col-xs-offset-4 col-xs-8">
                    <button type="submit" class="btn btn-primary" onclick= "return confirm('Are you sure you want to continue')">Update</button>
                </div>
            </div>
        </form>
    </div> <!-- /.container -->
</body>
<jsp:include page="../footer.jsp"/>
</html>
