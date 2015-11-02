<%-- 
    Document   : migrate
    Created on : Oct 5, 2015, 8:55:48 AM
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
            String query = "SELECT * FROM section";
            ResultList rs = DB.query(query);
            while(rs.next()) {
                query = "INSERT INTO section_lecturer (`sectionID`, `username`) VALUES ("+rs.getString("sectionID")+", '"+rs.getString("username")+"')";
                if(DB.update(query) == 0) {
                    out.print("Query Failed: "+ query + "<br>");
                }
            }
        %>
        <h1>Complete</h1>
    </body>
</html>
