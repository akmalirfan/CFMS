<%-- 
    Document   : AddSection
    Created on : Aug 16, 2015, 3:55:04 PM
    Author     : Kiwi
--%>
<jsp:include page="../header.jsp"/>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Add New Section</title>
    </head>
    <body>
        <div class="container">
            <form class='form-horizontal' action="<%=request.getContextPath()%>/CreateSectionServlet" method="POST">
                <jsp:include page="../component/semesterAutoComplete.jsp">
                    <jsp:param name="label" value="Semester: "/>
                </jsp:include>
                <div class="input-group">
                <span class="input-group-btn">
                    <button id="addRow" class="btn btn-primary" type="button" disabled>Add Section</button>
                </span>
                <jsp:include page="../component/offeredCourseAutoComplete.jsp">
                    <jsp:param name="semesterID" value='<%=request.getParameter("semesterID")%>'/>
                    <jsp:param name="selectAction" value="none"/>
                    <jsp:param name="id" value="offeredCourse"/>
                </jsp:include>
                </div>
                <%
                    String error = "Form Error";
                    if (session.getAttribute(error) != null) { // If there is an error during login
                %>
                        <div class="alert alert-danger" role="alert">
                            <span class="glyphicon glyphicon-remove" aria-hidden="true" style="padding-right: 10px"></span>
                            <strong><%=session.getAttribute(error) %></strong>
                        </div>
                <%
                    session.removeAttribute(error);
                    }
                %>
                <table class="table" id="sectionTable">
                    <thead>
                    <tr>
                        <th data-field="course" style="width:30%">Course</th>
                        <th data-field="lecturer" style="width:30%">Lecturer</th>
                        <th data-field="sectionNo" style="width:15%">Section No</th>
                        <th data-field="sectionMajor" style="width:20%">Section Major</th>
                        <th data-field="sectionNo" style="width:5%"></th>
                    </tr>
                    </thead>
                    <tbody>
                    </tbody>
                </table>
                <% if(request.getParameter("semesterID") != null) {%>                    
                    <button type="submit" class='btn btn-primary' id="submit" disabled>Submit</button>
                <% } %>
            </form>
            <script>
            $button = $('#addRow');
            var rowNum = 0;
            if($("#offeredCourse").val() !== null) {
                $button.prop("disabled", false);
            }
            $("#offeredCourse").change( function() {
                if($(this).val() !== null) {
                    $button.prop("disabled", false); 
                } else {
                    $button.prop("disabled", true);
                }
            });
            $button2 = $('.remove-row');
            $(function () {
                $button.click(function () {
                    var row = "<tr id=\""+rowNum+"\">";
                    row += "<td>" + $(".offeredCourse :selected").text();
                    row += "<input name=\"course_offered_ID\" class=\"hidden\" value=\""+$(".offeredCourse").val()+"\"></td>";
                    row += "<td>" + $("#selectLecturer").html() + "</td>";
                    row += "<td>" + $("#selectSectionNo").html() + "</td>";
                    row += "<td>" + $("#selectSectionMajor").html() + "</td>";
                    row += "<td><button type=\"button\" class=\"btn btn-sm btn-info remove-row\"><span class=\"glyphicon glyphicon-remove\"></span> Remove</button></td>";
                    row += "</tr>";
                    $('#sectionTable tbody:last').append(row);
                    $("#sectionTable tr").last().find("#lecturerName").select2();
                    $("#sectionTable tr").last().find("#lecturerName").attr("name", "username-"+rowNum);
                    $("#sectionTable tr").last().find(".remove-row").click( function() {
                        $(this).closest('tr').remove();
                        --rowNum;
                        if(rowNum == 0)
                            $("#submit").prop("disabled", true);
                    });
                    ++rowNum;
                    if(rowNum > 0)
                        $("#submit").prop("disabled", false);
                });
            });
            </script>
            <div class="hidden">
                <div id="selectLecturer">
                    <jsp:include page="../component/lecturerAutoComplete.jsp">
                        <jsp:param name="id" value="lecturerName"/>
                        <jsp:param name="multiple" value="true"/>
                    </jsp:include>
                </div>
                <div id="selectSectionNo">
                    <select class="form-control" name="sectionNo" id="sectionNo">
                        <% 
                        for(int i = 1; i <= 10; ++i) {
                            out.print("<option>");
                            out.print(i);
                            out.print("</option>");
                        }
                        %>
                    </select>
                </div>
                <div id="selectSectionMajor">
                    <select class="form-control" name="sectionMajor" id="sectionMajor">
                        <%
                        String[] majors = {"SCSJ", "SCSR", "SCSV", "SCSB", "Mixed", "UNSRI"};
                        for(String major: majors) {
                            out.print("<option>");
                            out.print(major);
                            out.print("</option>");
                        }
                        %>
                    </select>
                </div>
            </div>
        </div>
    </body>
    <jsp:include page="../footer.jsp"/>
</html>

