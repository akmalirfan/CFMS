<%-- 
    Document   : migrateCourse
    Created on : Oct 5, 2015, 9:19:55 AM
    Author     : Kiwi
--%>

<%@page import="common.ResultList"%>
<%@page import="common.DB"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            String query = "SELECT * FROM course_new";
            ResultList rs = DB.query(query);
            while(rs.next()) {
                String query2 = "UPDATE course SET shortForm='"+rs.getString("shortForm")+"' WHERE courseCode='"+rs.getString("courseCode")+"' AND courseID="+rs.getString("courseID")+"";
                if(DB.update(query2) == 0) {
                    out.print("Query Failed: "+ query2 + "<br>");
                }
            }
            query = "SELECT * FROM course";
            rs = DB.query(query);
            while(rs.next()) {
                if(rs.getString("shortForm") == null || rs.getString("shortForm").equals("")) {
                    String query2 = "UPDATE course SET shortForm='"+rs.getString("courseName")+"' WHERE courseCode='"+rs.getString("courseCode")+"' AND courseID="+rs.getString("courseID")+"";
                    if(DB.update(query2) == 0) {
                        out.print("Query Failed: "+ query2 + "<br>");
                    }
                }
            }
        %>
        <h1>Complete</h1>
    </body>
</html>
