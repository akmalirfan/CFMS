<%-- 
    Document   : courseAutoComplete
    Created on : Aug 13, 2015, 12:23:47 AM
    Author     : Kiwi
--%>
<%@page import="common.ViewPermission"%>
<%@page import="AutoComplete.Select2OptionGenerator"%>
<%@page import="java.util.HashMap"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<select class="form-control" id="courseName" style="width:100%">
<%
    if(request.getParameter("permission") != null) {
        String viewPermission = request.getParameter("permission");
        ViewPermission requestPermission = ViewPermission.valueOf(viewPermission);
    } else if(request.getParameter("with filter") != null) {
        
    }
    String query = "Select * FROM course ORDER BY courseCode, courseID";
    HashMap<String,String> extra = new HashMap();
    extra.put("value", "[courseCode]/[courseID]");
    extra.put("text", "[courseCode] [courseID] [courseName]");
    out.print(Select2OptionGenerator.generate(query, "text", extra));
%>
</select>
<div class="hidden">
<input class="form-control" name="courseCode" id="courseCode" disabled>
<input class="form-control" name="courseID" id="courseID" disabled>
<input class="form-control" name="creditHours" id="creditHours" disabled>
</div>
<script>
    $("#courseName").select2({
        <% if(request.getParameter("placeholder") != null && !request.getParameter("placeholder").equals("")) { %>
        placeholder: "<%=request.getParameter("placeholder")%>",
        <% } else {%>
        placeholder: "Select A Course",
        <% } %>
        allowClear: true,
        theme: "bootstrap"
    });
    <% if(request.getParameter("course") != null && !request.getParameter("course").equals("")) { %>
    $("#courseName").select2("val", "<%=request.getParameter("course")%>");
    <% } else { %>
    $("#courseName").select2("val", "");    
    <% } %>
    $("#courseName").change(function() {
        select = $("#courseName :selected");
        <% if(request.getParameter("selectAction") != null) { 
            String action = request.getParameter("selectAction");
            if(action.equals("update")) { %>
            $("#courseCode").val(select.attr("courseCode"));
            $("#courseID").val(select.attr("courseID"));
            $("#creditHours").val(select.attr("creditHours"));
            <% } %>
        <%} else {%>
        dataSet = { 
            "course":select.val(),
        };
        var uri = new URI(window.location.href);
        var query = new URI(uri.search());
        var query = query.setSearch(dataSet);
        var uri = uri.pathname();
        var newQueryUrl = uri + query;
        window.location.href = newQueryUrl; 
        <% } %>
    });
</script>