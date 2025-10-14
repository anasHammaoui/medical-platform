<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<html>
<head>
    <title>Login Page</title>
    <style>
        body { font-family: Arial, sans-serif; background-color: #f0f0f0; display:flex; justify-content:center; align-items:center; height:100vh; }
        .container { background-color: white; padding: 30px; border-radius: 10px; box-shadow: 0 0 10px rgba(0,0,0,0.2); width: 300px; }
        input[type=email], input[type=password] { width: 100%; padding: 10px; margin: 10px 0; border-radius: 5px; border: 1px solid #ccc; }
        button {
            width: 100%;
            padding: 12px 24px;
            background-color: #3b82f6;
            color: #ffffff;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-size: 15px;
            font-weight: 500;
            transition: background-color 0.15s;
        }
        button:hover { background-color: #45a049; }
        .link { text-align: center; margin-top: 10px; }
    </style>
</head>
<body>
<div class="container">
    <h2>Login</h2>
    <form action="${pageContext.request.contextPath}/auth/login" method="post">
        <input type="email" name="email" placeholder="Email" required>
        <input type="password" name="password" placeholder="Password" required>
        <button type="submit">Login</button>
    </form>
    <div class="link">
        <a href="register.jsp">Don't have an account? Register</a>
    </div>
</div>
</body>
</html>