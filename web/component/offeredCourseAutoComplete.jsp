<%-- 
    Document   : offeredCourseAutoComplete
    Created on : Aug 16, 2015, 2:58:15 PM
    Author     : Kiwi
--%>

<%@page import="common.ViewPermission"%>
<%@page import="AutoComplete.Select2OptionGenerator"%>
<%@page import="java.util.HashMap"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<% if(request.getParameter("label") != null && !request.getParameter("label").equals("")) { %>
<label><%=request.getParameter("label")%></label>
<% } %>
<select class="form-control offeredCourse"
        <% if(request.getParameter("id") != null && !request.getParameter("id").equals("")) { %>
        id="<%=request.getParameter("id")%>"
        <% } %>
        >
<%
    if(request.getParameter("semesterID") == null || request.getParameter("semesterID").equals("") || request.getParameter("semesterID").equals("null")) {
    } else {
        String semesterID = request.getParameter("semesterID");
        String query = "Select * FROM course_offered AS co, course AS c WHERE co.courseID = c.courseID AND " +
                "co.courseCode = c.courseCode AND co.semesterID = " +semesterID+" ORDER BY c.courseCode, c.courseID";
        System.out.print(query);
        HashMap<String,String> extra = new HashMap();
        extra.put("value", "[course_offered_ID]");
        extra.put("text", "[courseCode] [courseID] [courseName]");
        out.print(Select2OptionGenerator.generate(query, "text", extra));
    }
%>
</select>
<script>
    $(".offeredCourse").select2({
        <% if(request.getParameter("placeholder") != null && !request.getParameter("placeholder").equals("")) { %>
        placeholder: "<%=request.getParameter("placeholder")%>",
        <% } else {%>
        placeholder: "Select An Offered Course",
        <% } %>
        allowClear: true,
        theme: "bootstrap"
    });
    <% if(request.getParameter("course_offered_ID") != null && (!request.getParameter("course_offered_ID").equals("") || !request.getParameter("course_offered_ID").equals("null"))) { %>
    $(".offeredCourse").select2("val", "<%=request.getParameter("course_offered_ID")%>");
    <% } else { %>
    $(".offeredCourse").select2("val", "");    
    <% } %>
    $(".offeredCourse").change(function() {
        select = $(".offeredCourse :selected");
        <% if(request.getParameter("selectAction") != null) { 
            String action = request.getParameter("selectAction");
            if(action.equals("none")) { %>
            <% } %>
        <%} else {%>
        dataSet = { 
            "course_offered_ID":select.val()
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
<% 
if(request.getParameter("semesterID") == null || request.getParameter("semesterID").equals("") || request.getParameter("semesterID").equals("null")) {
%>
<script>
    $(".offeredCourse").prop("disabled", true);
    $(".offeredCourse").attr("data-placeholder", "No Course Available for this semester");
    $(".offeredCourse").data("select2").setPlaceholder();
</script>
<%}%>