<%@page import="common.ResultList"%>
<jsp:include page="../header.jsp"/>
<%@ page import ="java.sql.*, common.DB, java.util.*" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Create Section - <%=session.getAttribute("User").toString()%></title>
    <script>
        <%if(request.getParameter("semesterID") != null) { %>
        $( document ).ready( function () {
            $(".semester-label").val($("#semester :selected").text());
            $(".semesterID").val($("#semester").val());
            <% if (request.getParameter("course") != null) { %>
            $(".courseCode").val($("#offeredCourse :selected").attr("courseCode"));
            $(".courseID").val($("#offeredCourse :selected").attr("courseID"));
            $(".course_offered_ID").val($("#offeredCourse").val());
            $(".course-label").val($("#offeredCourse :selected").text());
            <% } %>
        });
        var course = [];
        var count = 0;
        var NoResultsLabel = "No Course available for this semester yet";
        $.getJSON("<%=request.getContextPath()%>/ListSemesterCourseServlet", {
            label: "[courseCode] [courseID] [courseName]",
            value: "[courseCode] [courseID] [courseName]",
            semesterID: "<%=request.getParameter("semesterID")%>"
        },
        function( json ) {
            var keys = Object.keys(json);
            keys.forEach(function(key){
                course.push(json[key]);
                count++;
            });
            if (count === 0) {
                $(".course-label").val(NoResultsLabel);
                $(".course-label").prop('disabled', true);
                $("#filterCourse").val(NoResultsLabel);
                $("#filterCourse").prop('disabled', true);
                $("#newSectionBtn").prop('disabled', true);
            };
        });
        jQuery(function(){
            $("#filterCourse").autocomplete( {
                source: course,
                select: function( event, ui ) {
                    if (ui.item.label === NoResultsLabel) {
                        event.preventDefault();
                    }
                    dataSet = { 
                        "courseCode":ui.item.courseCode,
                        "courseID":ui.item.courseID, 
                        "course_offered_ID":ui.item.course_offered_ID,
                        "courseLabel":ui.item.label
                    };
                    var uri = new URI(window.location.href);
                    var query = new URI(uri.search());
                    var query = query.setSearch(dataSet);
                    var uri = uri.pathname();
                    var newQueryUrl = uri + query;
                    window.location.href = uri + query;
                },
                focus: function (event, ui) {
                    if (ui.item.label === NoResultsLabel) {
                        event.preventDefault();
                    }
                }
            });
        });
        jQuery(function(){
            $(".course-label").autocomplete( {
                source: course,
                select: function( event, ui ) {
                    if (ui.item.label === NoResultsLabel) {
                        event.preventDefault();
                    }
                    co_ID = $(this).attr('co_ID');
                    $("#course_offered_ID-"+co_ID).val(ui.item.course_offered_ID);
                    $("#courseCode-"+co_ID).val(ui.item.courseCode);
                    $("#courseID-"+co_ID).val(ui.item.courseID);
                },
                focus: function (event, ui) {
                    if (ui.item.label === NoResultsLabel) {
                        event.preventDefault();
                    }
                }
            });
        });
        <% } %>
    </script>
    <script>
        var lecturer = [];
        $.getJSON("<%=request.getContextPath()%>/ListLecturerServlet", {
            label: "[name]",
            value: "[name]"
        },
        function( json ) {
            var keys = Object.keys(json);
            keys.forEach(function(key){
                lecturer.push(json[key]);
            });
        });
        jQuery(function(){
            $(".lecturerName").autocomplete( {
                source: lecturer,
                select: function( event, ui ) {
                co_ID = $(this).attr('co_ID');
                $("#username-"+co_ID).val(ui.item.username);
            }
            });
        });
    </script>
</head>
<body>
    <div class="container">
        <div class="col-xs-5">
            <jsp:include page="../component/semesterAutoComplete.jsp"/>
        </div>
        <div class="col-xs-offset-1 col-xs-6">
            <jsp:include page="../component/offeredCourseAutoComplete.jsp">
                <jsp:param name="semesterID" value='<%=request.getParameter("semesterID")%>'/>
            </jsp:include>
        </div>
        <table class="table" id="resultTable"
            data-toggle="table" 
            data-search="true"
            data-pagination="true"
            data-show-toggle="true">
            <thead>
                <tr>
                    <th data-sortable="true">Course</th>
                    <th data-sortable="true">Lecturer</th>
                    <th data-sortable="true">Section</th>
                    <th data-sortable="true">Major</th>
                    <th data-sortable="true">Action</th>
                </tr>
            </thead>
            <tbody>
                <%
                if(request.getParameter("semesterID") != null) {
                    String semesterID = request.getParameter("semesterID");
                    String query = "";
                    if(request.getParameter("course_offered_ID") != null && !request.getParameter("course_offered_ID").equals("")) {
                        String co_ID = request.getParameter("course_offered_ID");
                        query = "SELECT c.courseCode AS courseCode, c.courseID AS courseID, c.courseName AS courseName, s.course_offered_ID AS course_offered_ID, " +
                                "s.sectionID AS sectionID, co.username AS penyelaras, s.username AS lecturer, s.sectionNo AS sectionNo, s.sectionMajor AS sectionMajor " +
                                "FROM course_offered AS co, section AS s, course AS c, profile AS p WHERE " +
                                "s.course_offered_ID = co.course_offered_ID AND s.courseCode = c.courseCode AND s.courseID = c.courseID AND " +
                                "s.username = p.username AND s.semesterID = " + semesterID + " " +
                                "AND s.course_offered_ID = " + co_ID;
                    }
                    else {
                        query = "SELECT c.courseCode AS courseCode, c.courseID AS courseID, c.courseName AS courseName, s.course_offered_ID AS course_offered_ID, " +
                                "s.sectionID AS sectionID, co.username AS penyelaras, s.username AS lecturer, s.sectionNo AS sectionNo, s.sectionMajor AS sectionMajor " +
                                "FROM course_offered AS co, section AS s, course AS c, profile AS p WHERE " +
                                "s.course_offered_ID = co.course_offered_ID AND s.courseCode = c.courseCode AND s.courseID = c.courseID AND " +
                                "s.username = p.username AND s.semesterID = " + semesterID;
                    }
                    ResultList rs = DB.query(query);
                    while(rs.next()) {
                        query = "SELECT * FROM section_lecturer AS sl, profile WHERE sl.username = profile.username AND sectionID=" + rs.getString("sectionID");
                        ResultList rs2 = DB.query(query);
                %>
                <tr>
                    <td><%=rs.getString("courseCode") + " " + rs.getString("courseID") + " " + rs.getString("courseName")%></td>
                    <td>
                    <%
                    while(rs2.next()) {
                    %>
                        <p>
                        <%
                        if(rs.getString("penyelaras") != null && !rs.getString("penyelaras").equals("") && rs.getString("penyelaras").equals(rs2.getString("username"))) {
                        %>
                        <span class="label label-primary">Penyelaras</span>
                        <% } else { %>
                        <a href="<%=request.getContextPath()%>/UpdatePenyelarasServlet?course_offered_ID=<%=rs.getString("course_offered_ID")%>&username=<%=rs2.getString("username")%>" class="btn btn-xs btn-default">Set Penyelaras</a>
                        <% } %>
                        <%=rs2.getString("name")%>
                        </p>
                    <%    
                    }
                    %>
                    </td>
                    <td><%=rs.getString("sectionNo")%></td>
                    <td><%=rs.getString("sectionMajor")%></td>
                    <td>
                        <a href="updateSection.jsp?sectionID=<%=rs.getString("sectionID")%>" class="btn btn-primary">Update</a>
                        <a href="<%=request.getContextPath()%>/DeleteSectionServlet?sectionID=<%=rs.getString("sectionID")%>" class="btn btn-danger">Delete</a>
                        
                    </td>
                </tr>
                <% } } %>
                </tbody>
        </table>
        <a href="<%=request.getContextPath()%>/root/addSection.jsp?semesterID=<%=request.getParameter("semesterID")%>&course_offered_ID=<%=request.getParameter("course_offered_ID")%>" class="btn btn-primary">Add New Section</a>
    </div> <!-- /.container -->
</body>
<jsp:include page="../footer.jsp"/>
</html>
