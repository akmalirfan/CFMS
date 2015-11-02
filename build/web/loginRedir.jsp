<%
    String loggedInUserType = (String) session.getAttribute("userType");
    
    if (loggedInUserType != null) {
        response.sendRedirect(request.getContextPath() + "/index.jsp");
    } else {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
    }
%>
