<%@page import="common.ResultList"%>
<jsp:include page="../header.jsp"/>
<%@ page import ="java.sql.*, common.DB" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>View Batch Courses - <%=session.getAttribute("User").toString()%></title>
    
    <script>
        var intake = [];
        $.getJSON("<%=request.getContextPath()%>/ListBatchServlet", {
            label: "[intake]",
            value: "[intake]"
        },
        function( json ) {
            var keys = Object.keys(json);
            keys.forEach(function(key){
                intake.push(json[key]);
            });
        });
        jQuery(function(){
            $("#intake").autocomplete( {
                source: intake,
                select: function( event, ui ) {
                    dataSet = { 
                        "batchID":ui.item.batchID, 
                        "intake":ui.item.label 
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
        jQuery(function($) {
            $('form').bind('submit', function() {
                $(this).find(':input').removeAttr('disabled');
            });
        });
    </script>
    
</head>
<body>


    <div class="container">
        <input class="form-control" id="intake" placeholder="Intake">

      <div class="col-md-6">
      <table class="table">
        <caption>Courses by Intake</caption>
        <thead>
            <tr>
                <th>Intake</th>
                <th>Course Code</th>
                <th>Course Name</th>
                <th>Credit Hours</th>
            </tr>
        </thead>
        <tbody>
            <%
  // ResultSet rs = DB.query("SELECT * FROM batch, batch_courses, course WHERE batch.batchID = batch_courses.batchID AND batch_courses.sem=1 AND course.courseCode=batch_courses.courseCode AND course.courseID=batch_courses.courseID ORDER BY batch.intake ASC");

 // ResultSet rs2 = DB.query("SELECT * FROM batch, batch_courses, course WHERE batch.batchID = batch_courses.batchID AND batch_courses.sem=2 AND course.courseCode=batch_courses.courseCode AND course.courseID=batch_courses.courseID ORDER BY batch.intake ASC");
if(request.getParameter("batchID") != null) {
    String batchID = request.getParameter("batchID");
    int i=1 ;
    while(i <=8){
    ResultList rs = DB.query("SELECT * FROM batch, batch_courses, course "
            + "WHERE batch.batchID = batch_courses.batchID "
            + "AND batch.batchID= '"+batchID+"'"
            + "AND batch_courses.sem= '"+i+"'"
            + "AND course.courseCode=batch_courses.courseCode "
            + "AND course.courseID=batch_courses.courseID "
            + "ORDER BY batch.intake ASC");

%>
        <tr><td><b>Sem <%=i %> </b></td><td></td><td></td><td></td></tr><% i++; %>
         <%while(rs.next()){ %>
            <tr>
                <td><%=rs.getString("intake") %></td>
                <td><%=rs.getString("courseCode") %> <%=rs.getString("courseID") %></td>
                <td><%=rs.getString("courseName") %></td>
                <td><%=rs.getString("creditHours") %></td>
            </tr>
        <% 

         } } } 
        %>
        </tbody>
      </table>
    </div>

    </div> <!-- /.container -->
</body>
<jsp:include page="../footer.jsp"/>
</html>