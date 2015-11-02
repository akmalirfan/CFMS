<jsp:include page="../header.jsp"/>
<%@ page import ="java.sql.*, common.DB" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Add Course - <%=session.getAttribute("User").toString()%></title>
</head>
<body>
    <div class="container">
        <form class="form-horizontal" method="post" action="<%=request.getContextPath()%>/addCourseDB">
            <div class="form-group">
                <label for="courseCode" class="control-label col-xs-4">Course Code</label>
                <div class="radio col-xs-8">
                    <label class="radio-inline courseCode"><input type="radio" name="courseCode" value="SCSJ">SCSJ</label>
                    <label class="radio-inline courseCode"><input type="radio" name="courseCode" value="SCSV">SCSV</label>
                    <label class="radio-inline courseCode"><input type="radio" name="courseCode" value="SCSR">SCSR</label>
                    <label class="radio-inline courseCode"><input type="radio" name="courseCode" value="SCSB">SCSB</label>
                    <label class="radio-inline courseCode"><input type="radio" id="otherCodeRadio" name="courseCode" value="other">Other</label>
                    <label class="radio-inline"><input type="text" class="form-control" id="otherCode" name="otherCode" placeholder="Please Specify"></label>
                </div>
            </div>

            <div class="form-group">
                <label for="courseID" class="control-label col-xs-4">Course ID</label>
                <div class="col-xs-8">
                    <input type="text" class="form-control" name="courseID" placeholder="Course ID">
                </div>
            </div>

            <div class="form-group">
                <label for="courseName" class="control-label col-xs-4">Course Name</label>
                <div class="col-xs-8">
                    <input type="text" class="form-control" name="courseName" placeholder="Course Name">
                </div>
            </div>
            
            <div class="form-group">
                <label for="courseName" class="control-label col-xs-4">Course Short Form</label>
                <div class="col-xs-8">
                    <input type="text" class="form-control" name="shortForm" placeholder="Short Form">
                </div>
            </div>
            
            <div class="form-group">
                <label for="creditHours" class="control-label col-xs-4">Credit Hours</label>
                <div class="radio col-xs-8">
                <label class="radio-inline"><input type="radio" name="creditHours" value="1">1</label>
                <label class="radio-inline"><input type="radio" name="creditHours" value="2">2</label>
                <label class="radio-inline"><input type="radio" name="creditHours" value="3">3</label>
                <label class="radio-inline"><input type="radio" name="creditHours" value="4">4</label>
                <label class="radio-inline"><input type="radio" name="creditHours" value="5">5</label>
                <label class="radio-inline"><input type="radio" name="creditHours" value="8">8</label>
                </div>
            </div>

            <div class="form-group">
                <div class="col-xs-offset-4 col-xs-8">
                    <button type="submit" class="btn btn-primary" onclick= "return confirm('Are you sure you want to continue')">Add</button>
                </div>
            </div>
        </form>
    </div> <!-- /.container -->
    <script>
        $("#otherCode").hide();
        $(".courseCode").change(function () {
            if ($("#otherCodeRadio").is(":checked")) {
                $("#otherCode").show();
            } else {
                $("#otherCode").hide();
            }
        });
    </script>
</body>

<jsp:include page="../footer.jsp"/>
</html>