<%@page import="common.ViewPermission"%>
<%@page import="common.Pair"%>
<%@page import="CourseFileManagementSystem.LecturerUploadValidator"%>
<jsp:include page="../header.jsp"/>
<%@ page import ="java.sql.*, common.DB, java.util.*" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Management View</title>
    <script src="<%=request.getContextPath()%>/javascript/bootstrap-table-filter-control.js"></script>
    <script>
        $(document).ready(function() {
           $('#sectionResult').bootstrapTable({
                url: "<%=request.getContextPath()%>/SectionSearch",
                search: false,
                pagination: "true",
                queryParams: function (p) {
                    return {
                        semesterID:$("#semester").val(),
                        departmentID:$("#departmentName").val(),
                        course:$("#courseName").val(),
                        username:$("#lecturerName").val(),
                        viewPermission:$("#viewPermission").val()
                    };
                },
                columns: [{
                    field: 'course',
                    title: 'Course',
                    sortable: true
                }, {
                    field: 'name',
                    title: 'Lecturer',
                    sortable: true
                }, {
                    field: 'sectionNo',
                    title: 'Section No',
                    sortable: true
                }, {
                    field: 'stat',
                    title: 'Upload Status'
                }, {
                    field: 'sectionID',
                    title: 'Section ID',
                    visible: false
                }, {
                    field: 'operate',
                    title: 'Manage',
                    align: 'center',
                    valign: 'middle',
                    clickToSelect: false,
                    events: "operateEvents",
                    formatter: operateFormatter
                }]
            });
            window.operateEvents = {
                'click .stats': function (e, value, row, index) {
                    dataSet = {                       
                        "sectionID": [row.sectionID]
                    };
                    var uri = new URI("<%=request.getContextPath()%>/upload/upload.jsp");
                    var query = new URI(uri.search());
                    var query = query.setSearch(dataSet);
                    window.location.href = uri + query;
                }
            };
            function operateFormatter(value, row, index) {
                return [
                    '<a class="stats" href="javascript:void(0)" title="Stats">',
                    '<i class="glyphicon glyphicon-stats"></i>',
                    '</a>  '
                ].join('');
            }
            $($(document).find("th[data-field=name]")).find("input[type=text]").attr('placeholder', "Filter by Name");
            $($(document).find("th[data-field=course]")).find("input[type=text]").attr('placeholder', "Filter by Course");
        });
    </script>
    
    <style type="text/css">
        form {
            max-width: 400px;
            margin: auto;
        }
    </style>
</head>
<body>
    
    <div class="container">
        <form class='form-horizontal' action="<%=request.getContextPath()%>/SectionSearch">
            <jsp:include page="../component/semesterAutoComplete.jsp">
                <jsp:param name="placeholder" value='Filter by Semester'/>
            </jsp:include>
            <% if(session.getAttribute("viewPermission")==ViewPermission.PENTADBIR) {%>
                <jsp:include page="../component/departmentAutoComplete.jsp">
                    <jsp:param name="permission" value='<%=session.getAttribute("viewPermission")%>'/>
                    <jsp:param name="placeholder" value='Filter by Department'/>
                </jsp:include>
            <% } %>
            <%--<jsp:include page="../component/courseAutoComplete.jsp">
                <jsp:param name="permission" value="<%=session.getAttribute("viewPermission")%>"/>
            </jsp:include>
            <jsp:include page="../component/lecturerAutoComplete.jsp">
                <jsp:param name="permission" value="<%=session.getAttribute("viewPermission")%>"/>
            </jsp:include>--%>
            <!--<button class="btn btn-primary" id="addCourse" >Search</button>-->
        </form>
        <table
            class="table"
            id="sectionResult"
            data-filter-control="true">
            <thead>
                <tr>
                    <th data-field="course" data-filter-control="input"></th>
                    <th data-field="name" data-filter-control="input"></th>
                </tr>
            </thead>
        </table>
    </div> <!-- /.container -->
</body>
<jsp:include page="../footer.jsp"/>
<html>