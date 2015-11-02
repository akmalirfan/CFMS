<%-- 
    Document   : semesterAutoComplete
    Created on : Aug 13, 2015, 12:14:27 AM
    Author     : Kiwi
--%>

<%@page import="common.ResultList"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="common.DB"%>
<%@page import="java.util.HashMap"%>
<%@page import="AutoComplete.Select2OptionGenerator"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<% if(request.getParameter("label") != null && !request.getParameter("label").equals("")) { %>
<label><%=request.getParameter("label")%></label>
<% } %>
<select name="semesterID" id="semester" class="form-control">
<%
    String query = "Select * FROM year_semester ORDER BY year DESC, semester DESC";
    HashMap<String,String> extra = new HashMap();
    extra.put("value", "[semesterID]");
    extra.put("text", "[year] / [semester]");
    out.print(Select2OptionGenerator.generate(query, "text", extra));
%>
</select>
<script>
    $("#semester").select2({
        <% if(request.getParameter("placeholder") != null && !request.getParameter("placeholder").equals("")) { %>
        placeholder: "<%=request.getParameter("placeholder")%>",
        <% } else {%>
        placeholder: "Select A Semester",
        <% } %>
        allowClear : true,
        theme: "bootstrap"
    });
    <% if(request.getParameter("semesterID") != null && (!request.getParameter("semesterID").equals("") || !request.getParameter("semesterID").equals("null"))) { %>
    $("#semester").select2("val", "<%=request.getParameter("semesterID")%>");
    <% } else { 
        query = "Select * FROM year_semester ORDER BY year DESC, semester DESC";
        ResultList rs = DB.query(query);
        rs.next();
    %>
    $("#semester").select2("val", "<%=rs.getString("semesterID")%>");
    dataSet = { 
        "semesterID":$("#semester").val()
    };
    var uri = new URI(window.location.href);
    var query = new URI(uri.search());
    var query = query.setSearch(dataSet);
    var uri = uri.pathname();
    var newQueryUrl = uri + query;
    window.location.href = newQueryUrl; 
    <% } %>
    $("#semester").change(function() {
        dataSet = { 
            "semesterID":$("#semester").val()
        };
        var uri = new URI(window.location.href);
        var query = new URI(uri.search());
        var query = query.setSearch(dataSet);
        var uri = uri.pathname();
        var newQueryUrl = uri + query;
        window.location.href = newQueryUrl; 
    });
</script>
<br>