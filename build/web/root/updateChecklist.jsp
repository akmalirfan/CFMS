<%@page import="common.ResultList"%>
<jsp:include page="../header.jsp"/>
<%@ page import ="java.sql.*, common.DB" %>
<%
	String checklistID = request.getParameter("checklistID");

	ResultList rs = DB.query("SELECT * FROM upload_checklist WHERE checklistID= '"+checklistID +"'");
        rs.next();
%>

<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Update Checklist - <%=session.getAttribute("User").toString()%></title>
    <script>
        jQuery(function($) {
            $('form').bind('submit', function() {
                $(this).find(':input').removeAttr('disabled');
            });
        });
    </script>
</head>

<body>
    <div class="container">
	<form class="form-horizontal" method="post" action="<%=request.getContextPath()%>/UpdateChecklistServlet">
            <div class="form-group" hidden>
                <label for="courseCode" class="control-label col-xs-4">Checklist ID</label>
                <div class="col-xs-8">
                    <input type="text" class="form-control" name="checklistID" value="<%=rs.getString("checklistID") %>" disabled>
                </div>
            </div>

            <div class="form-group">
                <label for="courseName" class="control-label col-xs-4">Label:</label>
                <div class="col-xs-8">
                    <input type="text" class="form-control" name="label" value="<%=rs.getString("label") %>">
                </div>
            </div>

            <div class="form-group">
                <label for="courseName" class="control-label col-xs-4">Description:</label>
                <div class="col-xs-8">
                    <input type="text" class="form-control" name="description" value="<%=rs.getString("description") %>">
                </div>
            </div>
                        
            <div class="form-group">
                <div class="col-xs-offset-4 col-xs-8">
                    <button type="submit" class="btn btn-primary" onclick= "return confirm('Are you sure you want to continue')">Update</button>
                </div>
            </div>
        </form>
    </div>
    <jsp:include page="../footer.jsp"/>
</body>