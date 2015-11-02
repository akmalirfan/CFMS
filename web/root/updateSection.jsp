<%-- 
    Document   : updateSection
    Created on : Sep 26, 2015, 11:16:03 AM
    Author     : Kiwi
--%>
<%@page import="common.ResultList"%>
<%@page import="AutoComplete.Select2OptionGenerator"%>
<%@page import="java.util.HashMap"%>
<jsp:include page="../header.jsp"/>
<%@page import="java.sql.ResultSet"%>
<%@page import="common.DB"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    String sectionID = request.getParameter("sectionID");
        String query = "SELECT * FROM course_offered AS co, section AS s, course AS c, profile AS p WHERE " +
                                "s.course_offered_ID = co.course_offered_ID AND s.courseCode = c.courseCode AND s.courseID = c.courseID AND " +
                                "s.username = p.username AND s.sectionID = " + sectionID;
	ResultList rs = DB.query(query);
        rs.next();
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Update Section</title>
    </head>
    <body>
        <div class="container">
            <form class='form-horizontal' action="<%=request.getContextPath()%>/UpdateSectionServlet">
                <div class="form-group">
                    <label for="course" >Course:</label>
                    <input id="course" type="text" class="form-control" name="course" value="<%=rs.getString("courseCode")%> <%=rs.getString("courseID")%> - <%=rs.getString("courseName")%>" disabled>
                </div>
                <div class="form-group">
                    <label>Lecturer Name:</label>
                    <select name= "username" class="form-control lecturerName" multiple="multiple">
                    <%
                        query = "Select u.username, p.name FROM user AS u, profile AS p WHERE u.username = p.username AND u.userType = 'lecturer' ORDER BY name";
                        HashMap<String,String> extra = new HashMap();
                        extra.put("value", "[username]");
                        extra.put("text", "[name]");
                        out.print(Select2OptionGenerator.generate(query, "text", extra));
                    %>
                    </select>
                    <script>
                        $(".lecturerName").select2({
                            placeholder: "Select A Lecturer",
                            allowClear : true,
                            theme: "bootstrap"
                        });
                        var lecturer = [
                        <%
                        query = "SELECT * FROM section_lecturer AS sl WHERE sl.sectionID = " + sectionID;
                        ResultList rs2 = DB.query(query);
                        while(rs2.next()) {
                            out.print("\""+rs2.getString("username")+"\",");
                        }
                        %>
                        ];
                        $(".lecturerName").select2("val", lecturer);
                    </script>
                </div>
                <div class="form-group">
                    <label for="sectionNo">Section Number:</label>
                    <select class="form-control" name="sectionNo" id="sectionNo">
                        <% 
                        for(int i = 1; i <= 10; ++i) {
                            if(i == Integer.parseInt((rs.getString("sectionNo")))) 
                                out.print("<option selected>");
                            else
                                out.print("<option>");
                            out.print(i);
                            out.print("</option>");
                        }
                        %>
                    </select>
                </div>
                <div class="form-group">
                    <label for="sectionMajor">Section Major:</label>
                    <select class="form-control" name="sectionMajor" id="sectionMajor">
                        <%
                        String[] majors = {"SCSJ", "SCSR", "SCSV", "SCSB", "Mixed", "UNSRI"};
                        for(String major: majors) {
                            if(major.equals(rs.getString("sectionMajor"))) 
                                out.print("<option selected>");
                            else
                                out.print("<option>");
                            out.print(major);
                            out.print("</option>");
                        }
                        %>
                    </select>
                </div>
                <div class= "hidden">
                    <input class="sectionID" name="sectionID" value="<%=rs.getString("sectionID")%>">
                </div> 
                <div class="form-group">
                    <button type="submit" class='btn btn-primary'>Update Section</button>
                </div>
            </form>
        </div>
    </body>
    <jsp:include page="../footer.jsp"/>
</html>
