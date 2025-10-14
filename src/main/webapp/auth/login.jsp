<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Login - Medical Platform</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }

        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, 'Helvetica Neue', Arial, sans-serif;
            background-color: #f5f7fa;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            padding: 40px 20px;
        }

        .container {
            background-color: #ffffff;
            padding: 48px;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
            border: 1px solid #e5e7eb;
            width: 100%;
            max-width: 450px;
        }

        .header {
            margin-bottom: 36px;
            text-align: center;
        }

        .header h2 {
            color: #1f2937;
            font-size: 24px;
            font-weight: 600;
            margin-bottom: 8px;
        }

        .header p {
            color: #6b7280;
            font-size: 14px;
        }

        .alert {
            padding: 14px 16px;
            border-radius: 6px;
            margin-bottom: 24px;
            font-size: 14px;
            border: 1px solid;
        }

        .alert-error {
            background-color: #fef2f2;
            color: #991b1b;
            border-color: #fecaca;
        }

        .alert-success {
            background-color: #f0fdf4;
            color: #166534;
            border-color: #bbf7d0;
        }

        .form-group {
            display: flex;
            flex-direction: column;
            margin-bottom: 20px;
        }

        label {
            margin-bottom: 8px;
            color: #374151;
            font-weight: 500;
            font-size: 14px;
        }

        .required {
            color: #dc2626;
            margin-left: 2px;
        }

        input[type=email],
        input[type=password] {
            width: 100%;
            padding: 10px 12px;
            border-radius: 6px;
            border: 1px solid #d1d5db;
            font-size: 14px;
            color: #1f2937;
            background-color: #ffffff;
            transition: border-color 0.15s, box-shadow 0.15s;
        }

        input:focus {
            outline: none;
            border-color: #3b82f6;
            box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.1);
        }

        input::placeholder {
            color: #9ca3af;
        }

        .form-actions {
            margin-top: 32px;
        }

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

        button:hover {
            background-color: #2563eb;
        }

        button:active {
            background-color: #1d4ed8;
        }

        .link {
            text-align: center;
            margin-top: 20px;
        }

        .link a {
            color: #3b82f6;
            text-decoration: none;
            font-size: 14px;
            font-weight: 500;
        }

        .link a:hover {
            color: #2563eb;
            text-decoration: underline;
        }

        @media (max-width: 768px) {
            .container {
                padding: 32px 24px;
            }
        }
    </style>
</head>
<body>
<div class="container">
    <div class="header">
        <h2>Sign In</h2>
        <p>Access your account</p>
    </div>

    <c:if test="${not empty errorMessage}">
        <div class="alert alert-error">
                ${errorMessage}
        </div>
    </c:if>

    <c:if test="${not empty successMessage}">
        <div class="alert alert-success">
                ${successMessage}
        </div>
    </c:if>

    <form action="${pageContext.request.contextPath}/auth/login" method="post">
        <div class="form-group">
            <label for="email">Email Address <span class="required">*</span></label>
            <input type="email" id="email" name="email" placeholder="your@email.com" required>
        </div>

        <div class="form-group">
            <label for="password">Password <span class="required">*</span></label>
            <input type="password" id="password" name="password" placeholder="Enter your password" required>
        </div>

        <div class="form-actions">
            <button type="submit">Sign In</button>
        </div>
    </form>

    <div class="link">
        <a href="${pageContext.request.contextPath}/auth/register">Don't have an account? Sign up</a>
    </div>
</div>
</body>
</html>