<%-- 
    Document   : departmentAutoComplete
    Created on : Aug 13, 2015, 2:05:52 PM
    Author     : Kiwi
--%>

<%@page import="AutoComplete.Select2OptionGenerator"%>
<%@page import="java.util.HashMap"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<select class="form-control" id="departmentName" style="width:100%">
<%
    String query = "Select * FROM department ORDER BY department";
    HashMap<String,String> extra = new HashMap();
    extra.put("value", "[departmentID]");
    extra.put("text", "[department]");
    out.print(Select2OptionGenerator.generate(query, "text", extra));
%>
</select>
<script>
    $("#departmentName").select2({
        <% if(request.getParameter("placeholder") != null && !request.getParameter("placeholder").equals("")) { %>
        placeholder: "<%=request.getParameter("placeholder")%>",
        <% } else {%>
        placeholder: "Select A Department",
        <% } %>
        allowClear : true,
        theme: "bootstrap"
    });
    <% if(request.getParameter("departmentID") != null && !request.getParameter("departmentID").equals("")) { %>
    $("#departmentName").select2("val", "<%=request.getParameter("departmentID")%>");
    <% } else { %>
    $("#departmentName").select2("val", "");    
    <% } %>
    $("#departmentName").change(function() {
        dataSet = { 
            "departmentID":$("#departmentName").val()
        };
        var uri = new URI(window.location.href);
        var query = new URI(uri.search());
        var query = query.setSearch(dataSet);
        var uri = uri.pathname();
        var newQueryUrl = uri + query;
        window.location.href = newQueryUrl; 
    });
</script>
