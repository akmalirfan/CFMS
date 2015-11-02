
<%@page import="common.ResultList"%>
<jsp:include page="../header.jsp"/>
<%@ page import ="java.sql.*, common.DB" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>View Checklist - <%=session.getAttribute("User").toString()%></title>
</head>
<body>

<%
    ResultList rs = DB.query("SELECT * FROM upload_checklist WHERE status='active'");
    int cnt = 1;
%>

    <div class="container">
      <table 
          data-toggle="table" 
          data-search="true"
          data-show-toggle="true">
        <thead>
            <tr>
                <th data-field="checklistID" style="width:10%">ID</th>
                <th data-field="label" style="width:30%">Label</th>
                <th data-field="description" style="width:50%">Description</th>
                <th data-field="action" style="width:10%">Action</th>
            </tr>
        </thead>
        <tbody>
        <%while(rs.next()){ %>
            <tr>
                <td><%=cnt++%></td>
                <td><%=rs.getString("label") %></td>
                <td><%=rs.getString("description") %></td>
                <td><a href="updateChecklist.jsp?checklistID=<%=rs.getString("checklistID")%>"><button class="btn btn-primary btn-xs"><span class="glyphicon glyphicon-upload"></span>Update</button></a>
                <a href="<%=request.getContextPath()%>/DeleteChecklistServlet?checklistID=<%=rs.getString("checklistID")%>"><button class="btn btn-danger btn-xs" onclick= "return confirm('Are you sure you want to continue')"><span class="glyphicon glyphicon-remove"></span>Delete</button></a></td>
            </tr>
        <% } %>
        </tbody>
      </table>
 <p>
    <br>  
    <a role="button" pull-right class="btn btn-primary btn-md glyphicon glyphicon-plus-sign" href="addChecklist.jsp">
       <font color = "white" size = "3.5"> Add </font>
    </a>
</p>

    </div> <!-- /.container -->
</body>
<jsp:include page="../footer.jsp"/>
</html>