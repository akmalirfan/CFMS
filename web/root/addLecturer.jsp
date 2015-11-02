<%@page import="common.ResultList"%>
<%@page import="common.ViewPermission"%>
<jsp:include page="../header.jsp"/>
<%@ page import ="java.sql.*, common.DB" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Add Lecturer - <%=session.getAttribute("User").toString()%></title>
    <script>
        $('input[name=radioName]:checked', '#myForm').val()
    </script>
</head>
<body>
    <div class="container">
		<form class="form-horizontal" method="post" action="<%=request.getContextPath()%>/addLecturerDB">
            <div class="form-group">
                 <label for="username" class="control-label col-xs-4">Username</label>
                     <div class="col-xs-8">
                                <input type="text" class="form-control" name="username" placeholder="username">
                            </div>
                        </div>
                        
                        <div class="form-group">
                            <label for="password" class="control-label col-xs-4">Password</label>
                            <div class="col-xs-8">
                                <input type="password" class="form-control" name="password" placeholder="Password">
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="name" class="control-label col-xs-4">Name</label>
                            <div class="col-xs-8">
                                <input type="text" class="form-control" name="name" placeholder="Name">
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="password" class="control-label col-xs-4">Email Address</label>
                            <div class="col-xs-8">
                                <input type="text" class="form-control" name="emailAdd" placeholder="Email Address">
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="phoneNo" class="control-label col-xs-4">Phone Number</label>
                            <div class="col-xs-8">
                                <input type="text" class="form-control" name="phoneNo" placeholder="Phone Number">
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="department" class="control-label col-xs-4">Department</label>
                            <div class="radio col-xs-8">
                                <% 
                                String query = "SELECT * FROM department";
                                ResultList rs = DB.query(query);
                                while(rs.next()) {
                                %>
                                    <label class="radio-inline"><input type="radio" name="department" value="<%=rs.getString("departmentID")%>"><%=rs.getString("department")%></label>
                                <% } %>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="status" class="control-label col-xs-4">Status</label>
                            <div class="radio col-xs-8">
                                <%
                                String[] statuses = {"Active", "Inactive"};
                                for(String status: statuses) {
                                %>
                                    <label class="radio-inline"><input type="radio" name="status" value="<%=status%>"><%=status%></label>
                                <% } %>
                            </div>
                        </div>
            
                        <div class="form-group">
                            <label for="view" class="control-label col-xs-4">View Permission</label>					 
                            <div class="radio col-xs-8">
                                <% 
                                for(ViewPermission vp: ViewPermission.values()) {
                                %>
                                    <label class="radio-inline"><input type="radio" name="view" value="<%=vp.name()%>"><%=vp.toString()%></label>
                                <% } %>
                            </div>
                        </div>
                        
                        <div class="form-group">
                            <div class="col-xs-offset-4 col-xs-8">
                                <button type="submit" class="btn btn-primary" onclick= "return confirm('Are you sure you want to continue')">Add</button>
                            </div>
                        </div>
                    </form>


    </div> <!-- /.container -->
</body>
<jsp:include page="../footer.jsp"/>
</html>