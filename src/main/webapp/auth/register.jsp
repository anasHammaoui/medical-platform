<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Register - Medical Platform</title>
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
            max-width: 900px;
        }

        .header {
            margin-bottom: 36px;
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

        .form-row {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 24px;
            margin-bottom: 24px;
        }

        .form-row.single {
            grid-template-columns: 1fr;
        }

        .form-group {
            display: flex;
            flex-direction: column;
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

        input[type=text],
        input[type=email],
        input[type=password],
        input[type=number],
        select {
            width: 100%;
            padding: 10px 12px;
            border-radius: 6px;
            border: 1px solid #d1d5db;
            font-size: 14px;
            color: #1f2937;
            background-color: #ffffff;
            transition: border-color 0.15s, box-shadow 0.15s;
        }

        input:focus, select:focus {
            outline: none;
            border-color: #3b82f6;
            box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.1);
        }

        input::placeholder {
            color: #9ca3af;
        }

        select {
            cursor: pointer;
        }

        .conditional-fields {
            display: none;
        }

        .conditional-fields.show {
            display: contents;
        }

        .form-actions {
            margin-top: 32px;
            padding-top: 24px;
            border-top: 1px solid #e5e7eb;
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

            .form-row {
                grid-template-columns: 1fr;
                gap: 20px;
            }
        }
    </style>
</head>
<body>
<div class="container">
    <div class="header">
        <h2>Create an Account</h2>
        <p>Please fill in the information below to register</p>
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

    <form action="${pageContext.request.contextPath}/auth/register" method="post" id="registerForm">
        <!-- Personal Information -->
        <div class="form-row">
            <div class="form-group">
                <label for="fName">First Name <span class="required">*</span></label>
                <input type="text" id="fName" name="fName" required>
            </div>

            <div class="form-group">
                <label for="lName">Last Name <span class="required">*</span></label>
                <input type="text" id="lName" name="lName" required>
            </div>
        </div>

        <!-- Account Information -->
        <div class="form-row">
            <div class="form-group">
                <label for="email">Email Address <span class="required">*</span></label>
                <input type="email" id="email" name="email" required>
            </div>

            <div class="form-group">
                <label for="password">Password <span class="required">*</span></label>
                <input type="password" id="password" name="password" required minlength="6" placeholder="Minimum 6 characters">
            </div>
        </div>

        <!-- Role Selection -->
        <div class="form-row single">
            <div class="form-group">
                <label for="role">Role <span class="required">*</span></label>
                <select id="role" name="role" required>
                    <option value="">Select a role</option>
                    <option value="ADMIN">Administrator</option>
                    <option value="GENERALISTE">General Practitioner</option>
                    <option value="SPECIALISTE">Specialist Doctor</option>
                    <option value="INFERMIER">Nurse</option>
                </select>
            </div>
        </div>

        <!-- Conditional: Telephone (for GENERALISTE and SPECIALISTE) -->
        <div id="telephoneFields" class="conditional-fields">
            <div class="form-row single">
                <div class="form-group">
                    <label for="telephone">Phone Number</label>
                    <input type="text" id="telephone" name="telephone" placeholder="+212 6XX XXX XXX">
                </div>
            </div>
        </div>

        <!-- Conditional: Specialiste Fields -->
        <div id="specialisteFields" class="conditional-fields">
            <div class="form-row">
                <div class="form-group">
                    <label for="specialite">Specialty <span class="required">*</span></label>
                    <select id="specialite" name="specialite">
                        <option value="">Select a specialty</option>
                        <option value="CARDIOLOGIE">Cardiology</option>
                        <option value="PNEUMOLOGIE">Pulmonology</option>
                        <option value="DERMATOLOGIE">Dermatology</option>
                        <option value="PEDIATRIE">Pediatrics</option>
                        <option value="NEUROLOGIE">Neurology</option>
                    </select>
                </div>

                <div class="form-group">
                    <label for="tarif">Consultation Fee (DH)</label>
                    <input type="number" id="tarif" name="tarif" placeholder="200" min="0" step="50">
                </div>
            </div>
            <div class="form-group" style="display: none" >
                <input type="text" name="token" value="${sessionScope.csrfToken}">
            </div>
            <div class="form-row single">
                <div class="form-group">
                    <label for="dureeConsultation">Consultation Duration (minutes)</label>
                    <input type="number" id="dureeConsultation" name="dureeConsultation" placeholder="30" min="15" step="5">
                </div>
            </div>
        </div>

        <div class="form-actions">
            <button type="submit">Create Account</button>
        </div>
    </form>

    <div class="link">
        <a href="${pageContext.request.contextPath}/auth/login">Already have an account? Sign in</a>
    </div>
</div>

<script>
    function toggleConditionalFields() {
        const role = document.getElementById('role').value;
        const telephoneFields = document.getElementById('telephoneFields');
        const specialisteFields = document.getElementById('specialisteFields');
        const specialiteSelect = document.getElementById('specialite');

        // Reset all conditional fields
        telephoneFields.classList.remove('show');
        specialisteFields.classList.remove('show');
        specialiteSelect.removeAttribute('required');

        // Show fields based on role
        if (role === 'GENERALISTE' || role === 'SPECIALISTE') {
            telephoneFields.classList.add('show');
        }

        if (role === 'SPECIALISTE') {
            specialisteFields.classList.add('show');
            specialiteSelect.setAttribute('required', 'required');
        }
    }

    // Attach event listener
    document.getElementById('role').addEventListener('change', toggleConditionalFields);

    // Initialize on page load
    document.addEventListener('DOMContentLoaded', toggleConditionalFields);
</script>
</body>
</html>