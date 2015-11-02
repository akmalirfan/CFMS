<jsp:include page="../header.jsp"/>
<%@ page import ="java.sql.*, common.DB" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Add Checklist - <%=session.getAttribute("User").toString()%></title>
</head>
<body>
    <div class="container">
        <form class="form-horizontal" method="post" action="<%=request.getContextPath()%>/AddChecklistServlet">
            <div class="form-group">
                <label for="courseID" class="control-label col-xs-4">Label:</label>
                <div class="col-xs-8">
                    <input type="text" class="form-control" name="label" placeholder="Checklist Label">
                </div>
            </div>

            <div class="form-group">
                <label for="courseName" class="control-label col-xs-4">Description:</label>
                <div class="col-xs-8">
                    <input type="text" class="form-control" name="description" placeholder="Checklist Desription">
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