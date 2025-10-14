<%--
  Created by IntelliJ IDEA.
  User: LENOVO
  Date: 10/13/2025
  Time: 7:22 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Register Page</title>
    <style>
        body { font-family: Arial, sans-serif; background-color: #f0f0f0; display:flex; justify-content:center; align-items:center; height:100vh; }
        .container { background-color: white; padding: 30px; border-radius: 10px; box-shadow: 0 0 10px rgba(0,0,0,0.2); width: 300px; }
        input[type=text], input[type=email], input[type=password] { width: 100%; padding: 10px; margin: 10px 0; border-radius: 5px; border: 1px solid #ccc; }
        button { width: 100%; padding: 10px; background-color: #2196F3; color: white; border: none; border-radius: 5px; cursor: pointer; }
        button:hover { background-color: #0b7dda; }
        .link { text-align: center; margin-top: 10px; }
    </style>
</head>
<body>
<div class="container">
    <h2>Register</h2>
    <form action="${pageContext.request.contextPath}/auth/register" method="post">
        <input type="text" name="fName" placeholder="Full Name" required>
        <input type="text" name="lName" placeholder="Last Name" required>
        <input type="email" name="email" placeholder="Email" required>
        <input type="password" name="password" placeholder="Password" required>
        <button type="submit">Register</button>
    </form>
    <div class="link">
        <a href="${pageContext.request.contextPath}/auth/login">Already have an account? Login</a>
    </div>
</div>
</body>
</html>
