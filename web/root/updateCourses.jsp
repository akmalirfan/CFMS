<%@page import="common.ResultList"%>
<jsp:include page="../header.jsp"/>
<%@ page import ="java.sql.*, common.DB" %>
<%
	String courseCode = request.getParameter("courseCode");
    String courseID = request.getParameter("courseID");

	ResultList rs = DB.query("SELECT * FROM course WHERE courseCode= '"+courseCode +"' AND courseID= '" + courseID + "'");
        rs.next();
%>

<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Update Course - <%=session.getAttribute("User").toString()%></title>
</head>

<body>
    <div class="container">
	<form class="form-horizontal" method="post" action="<%=request.getContextPath()%>/updateCoursesDB?courseCode=<%=rs.getString("courseCode")%>&courseID=<%=rs.getString("courseID")%>">
            <div class="form-group">
                            <label for="courseCode" class="control-label col-xs-4">Course Code</label>
                            <div class="col-xs-8">
                                <input type="text" class="form-control" value="<%=rs.getString("courseCode") %> <%=rs.getString("courseID") %>" disabled>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="courseName" class="control-label col-xs-4">Course Name</label>
                            <div class="col-xs-8">
                                <input type="text" class="form-control" name="courseName" value="<%=rs.getString("courseName") %>">
                            </div>
                        </div>


                        <div class="form-group">
                            <label for="creditHours" class="control-label col-xs-4">Credit Hours</label>
                            <div class="col-xs-8">
                                <input type="text" class="form-control" value="<%=rs.getString("creditHours") %>" disabled>
                            <div class="radio">
                            <label class="radio-inline"><input type="radio" name="creditHours" value="1">1</label>
                            <label class="radio-inline"><input type="radio" name="creditHours" value="2">2</label>
                            <label class="radio-inline"><input type="radio" name="creditHours" value="3">3</label>
                            <label class="radio-inline"><input type="radio" name="creditHours" value="4">4</label>
                            <label class="radio-inline"><input type="radio" name="creditHours" value="5">5</label>
                            <label class="radio-inline"><input type="radio" name="creditHours" value="8">8</label>
                            </div>
                            </div>
                        </div>
                        
                        <div class="form-group">
                            <div class="col-xs-offset-4 col-xs-8">
                                <button type="submit" class="btn btn-primary" onclick= "return confirm('Are you sure you want to continue')">Update</button>
                            </div>
                        </div>
                    </form>
    </div>
</body>
<jsp:include page="../footer.jsp"/>
</html>