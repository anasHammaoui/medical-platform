<%@ page import="com.example.medicalplatform.model.Admin" %><%--
  Created by IntelliJ IDEA.
  User: LENOVO
  Date: 10/14/2025
  Time: 11:04 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>home</title>
</head>
<body>
    <h2><% String welcome =  request.getAttribute("auth") != null ? (String) request.getAttribute("auth") : "nothing yet"; %> <%=welcome%></h2>
<h2><%
    Admin admin = (Admin) session.getAttribute("admin");
    String name = admin != null ? admin.getNom() + " " + admin.getPrenom(): "no session";
%> <%= name %></h2>
<hr>
<a href="${pageContext.request.contextPath}/auth/logout">Logout</a>
</body>
</html>
