<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>
<c:set var="patients" value="${requestScope.patients}" />
<!DOCTYPE html>
<html lang="fr">
<head>
    <title>Tableau de Bord Infirmier - Plateforme Médicale</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }

        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, 'Helvetica Neue', Arial, sans-serif;
            background-color: #f5f7fa;
            min-height: 100vh;
        }

        /* Header */
        .header {
            background-color: #ffffff;
            border-bottom: 1px solid #e5e7eb;
            padding: 20px 40px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .header h1 {
            color: #1f2937;
            font-size: 24px;
            font-weight: 600;
        }

        .header-actions {
            display: flex;
            gap: 12px;
            align-items: center;
        }

        .btn {
            padding: 10px 20px;
            border-radius: 6px;
            border: none;
            cursor: pointer;
            font-size: 14px;
            font-weight: 500;
            transition: all 0.15s;
        }

        .btn-primary {
            background-color: #3b82f6;
            color: #ffffff;
        }

        .btn-primary:hover {
            background-color: #2563eb;
        }

        .btn-secondary {
            background-color: #6b7280;
            color: #ffffff;
        }

        .btn-secondary:hover {
            background-color: #4b5563;
        }

        /* Main Container */
        .container {
            max-width: 1400px;
            margin: 0 auto;
            padding: 40px;
        }

        /* Stats Cards */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 24px;
            margin-bottom: 32px;
        }

        .stat-card {
            background-color: #ffffff;
            padding: 24px;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
            border: 1px solid #e5e7eb;
        }

        .stat-card h3 {
            color: #6b7280;
            font-size: 14px;
            font-weight: 500;
            margin-bottom: 8px;
        }

        .stat-card .value {
            color: #1f2937;
            font-size: 32px;
            font-weight: 600;
        }

        /* Patient List */
        .patient-section {
            background-color: #ffffff;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
            border: 1px solid #e5e7eb;
        }

        .section-header {
            padding: 24px;
            border-bottom: 1px solid #e5e7eb;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .section-header h2 {
            color: #1f2937;
            font-size: 18px;
            font-weight: 600;
        }

        .table-container {
            overflow-x: auto;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        th, td {
            padding: 16px 24px;
            text-align: left;
        }

        th {
            background-color: #f9fafb;
            color: #6b7280;
            font-size: 12px;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.05em;
        }

        td {
            color: #1f2937;
            font-size: 14px;
            border-bottom: 1px solid #e5e7eb;
        }

        tr:hover td {
            background-color: #f9fafb;
        }

        .status-badge {
            display: inline-block;
            padding: 4px 12px;
            border-radius: 12px;
            font-size: 12px;
            font-weight: 500;
        }

        .status-waiting {
            background-color: #fef3c7;
            color: #92400e;
        }

        .status-consultation {
            background-color: #dbeafe;
            color: #1e40af;
        }

        .status-completed {
            background-color: #d1fae5;
            color: #065f46;
        }

        .action-btn {
            padding: 6px 12px;
            border-radius: 4px;
            border: 1px solid #d1d5db;
            background-color: #ffffff;
            color: #374151;
            cursor: pointer;
            font-size: 13px;
            transition: all 0.15s;
        }

        .action-btn:hover {
            background-color: #f3f4f6;
            border-color: #9ca3af;
        }

        /* Modal */
        .modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
            z-index: 1000;
            overflow-y: auto;
            padding: 40px 20px;
        }

        .modal.active {
            display: flex;
            justify-content: center;
            align-items: flex-start;
        }

        .modal-content {
            background-color: #ffffff;
            border-radius: 8px;
            box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 900px;
            margin: auto;
        }

        .modal-header {
            padding: 24px;
            border-bottom: 1px solid #e5e7eb;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .modal-header h2 {
            color: #1f2937;
            font-size: 20px;
            font-weight: 600;
        }

        .close-btn {
            background: none;
            border: none;
            font-size: 24px;
            color: #6b7280;
            cursor: pointer;
            padding: 0;
            width: 32px;
            height: 32px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 4px;
        }

        .close-btn:hover {
            background-color: #f3f4f6;
        }

        .modal-body {
            padding: 24px;
            max-height: calc(100vh - 250px);
            overflow-y: auto;
        }

        .form-row {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 20px;
            margin-bottom: 20px;
        }

        .form-row.three-col {
            grid-template-columns: repeat(3, 1fr);
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
        input[type=date],
        input[type=number],
        textarea {
            width: 100%;
            padding: 10px 12px;
            border-radius: 6px;
            border: 1px solid #d1d5db;
            font-size: 14px;
            color: #1f2937;
            background-color: #ffffff;
            transition: border-color 0.15s, box-shadow 0.15s;
        }

        textarea {
            resize: vertical;
            min-height: 80px;
            font-family: inherit;
        }

        input:focus, textarea:focus {
            outline: none;
            border-color: #3b82f6;
            box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.1);
        }

        input::placeholder, textarea::placeholder {
            color: #9ca3af;
        }

        .form-section {
            margin-bottom: 32px;
            padding-bottom: 24px;
            border-bottom: 1px solid #e5e7eb;
        }

        .form-section:last-child {
            border-bottom: none;
            margin-bottom: 0;
        }

        .form-section h3 {
            color: #1f2937;
            font-size: 16px;
            font-weight: 600;
            margin-bottom: 20px;
        }

        .section-description {
            color: #6b7280;
            font-size: 13px;
            margin-bottom: 16px;
            line-height: 1.5;
        }

        .vital-signs-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 20px;
        }

        .vital-sign-card {
            background-color: #f9fafb;
            padding: 16px;
            border-radius: 6px;
            border: 1px solid #e5e7eb;
        }

        .vital-sign-card label {
            display: flex;
            align-items: center;
            gap: 8px;
            margin-bottom: 8px;
            color: #1f2937;
        }

        .vital-sign-icon {
            font-size: 18px;
        }

        .input-with-unit {
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .input-with-unit input {
            flex: 1;
        }

        .unit {
            color: #6b7280;
            font-size: 14px;
            font-weight: 500;
            white-space: nowrap;
        }

        .modal-footer {
            padding: 24px;
            border-top: 1px solid #e5e7eb;
            display: flex;
            gap: 12px;
            justify-content: flex-end;
        }

        .btn-cancel {
            background-color: #ffffff;
            color: #374151;
            border: 1px solid #d1d5db;
        }

        .btn-cancel:hover {
            background-color: #f9fafb;
        }

        .alert {
            padding: 14px 16px;
            border-radius: 6px;
            margin-bottom: 20px;
            font-size: 14px;
            border: 1px solid;
        }

        .alert-success {
            background-color: #f0fdf4;
            color: #166534;
            border-color: #bbf7d0;
        }

        .alert-error {
            background-color: #fef2f2;
            color: #991b1b;
            border-color: #fecaca;
        }

        .info-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 16px;
        }

        .info-item {
            padding: 12px;
            background-color: #f9fafb;
            border-radius: 6px;
        }

        .info-item label {
            color: #6b7280;
            font-size: 12px;
            font-weight: 500;
            margin-bottom: 4px;
        }

        .info-item .value {
            color: #1f2937;
            font-size: 14px;
            font-weight: 500;
        }

        .vital-signs-display {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 12px;
            margin-top: 12px;
        }

        .vital-display-card {
            background-color: #f0f9ff;
            padding: 12px;
            border-radius: 6px;
            border: 1px solid #bfdbfe;
        }

        .vital-display-card label {
            color: #1e40af;
            font-size: 11px;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.05em;
            margin-bottom: 4px;
        }

        .vital-display-card .value {
            color: #1e3a8a;
            font-size: 16px;
            font-weight: 600;
        }

        @media (max-width: 768px) {
            .container {
                padding: 20px;
            }

            .header {
                padding: 16px 20px;
                flex-direction: column;
                gap: 12px;
                align-items: flex-start;
            }

            .form-row, .info-grid, .vital-signs-grid, .vital-signs-display {
                grid-template-columns: 1fr;
            }

            .form-row.three-col {
                grid-template-columns: 1fr;
            }

            .stats-grid {
                grid-template-columns: 1fr;
            }

            table {
                font-size: 12px;
            }

            th, td {
                padding: 12px;
            }

            .modal-content {
                max-width: 100%;
            }
        }
    </style>
</head>
<body>
<!-- Header -->
<div class="header">
    <h1>👨‍⚕️ Tableau de Bord Infirmier</h1>
    <div class="header-actions">
        <span style="color: #6b7280; font-size: 14px;">Bienvenue, ${sessionScope.user.prenom} ${sessionScope.user.nom}</span>
        <button class="btn btn-secondary" onclick="window.location.href='${pageContext.request.contextPath}/auth/logout'">Déconnexion</button>
    </div>
</div>

<!-- Main Container -->
<div class="container">
    <!-- Stats Cards -->
    <div class="stats-grid">
        <div class="stat-card">
            <h3>Total Patients Aujourd'hui</h3>
            <div class="value">${not empty patients ? patients.size() : 0}</div>
        </div>
        <div class="stat-card">
            <h3>En File d'Attente</h3>
            <div class="value" style="color: #f59e0b;">
                <c:set var="waitingCount" value="0"/>
                <c:forEach items="${patients}" var="patient">
                    <c:if test="${patient.fileAttente}">
                        <c:set var="waitingCount" value="${waitingCount + 1}"/>
                    </c:if>
                </c:forEach>
                ${waitingCount}
            </div>
        </div>
        <div class="stat-card">
            <h3>In Consultation</h3>
            <div class="value" style="color: #3b82f6;">
                <c:set var="consultCount" value="0"/>
                <c:forEach items="${patients}" var="patient">
                    <c:if test="${patient.fileAttente and not empty patient.dossierMedical and not empty patient.dossierMedical.consultations}">
                        <c:set var="consultCount" value="${consultCount + 1}"/>
                    </c:if>
                </c:forEach>
                ${consultCount}
            </div>
        </div>
        <div class="stat-card">
            <h3>Completed</h3>
            <div class="value" style="color: #10b981;">
                <c:set var="completedCount" value="0"/>
                <c:forEach items="${patients}" var="patient">
                    <c:if test="${not patient.fileAttente}">
                        <c:set var="completedCount" value="${completedCount + 1}"/>
                    </c:if>
                </c:forEach>
                ${completedCount}
            </div>
        </div>
    </div>

    <!-- Patient List Section -->
    <div class="patient-section">
        <div class="section-header">
            <h2>Patients Queue</h2>
            <button class="btn btn-primary" onclick="openAddPatientModal()">+ Register New Patient</button>
        </div>

        <c:if test="${not empty sessionScope.successMessage}">
            <div style="padding: 0 24px; padding-top: 20px;">
                <div class="alert alert-success">${sessionScope.successMessage}</div>
            </div>
            <c:remove var="successMessage" scope="session" />
        </c:if>

        <c:if test="${not empty requestScope.errorMessage}">
            <div style="padding: 0 24px; padding-top: 20px;">
                <div class="alert alert-error">${requestScope.errorMessage}</div>
            </div>
        </c:if>

        <div class="table-container">
            <table>
                <thead>
                <tr>
                    <th>Patient Name</th>
                    <th>Social Security</th>
                    <th>Phone</th>
                    <th>Arrival Time</th>
                    <th>Status</th>
                </tr>
                </thead>
                <tbody>
                <c:choose>
                    <c:when test="${empty patients}">
                        <tr>
                            <td colspan="6" style="text-align: center; color: #6b7280; padding: 40px;">
                                No patients registered today. Click "Register New Patient" to get started.
                            </td>
                        </tr>
                    </c:when>
                    <c:otherwise>
                        <c:forEach items="${patients}" var="patient">
                            <tr>
                                <td><strong>${patient.nom} ${patient.prenom}</strong></td>
                                <td>${patient.numeroSecuriteSociale}</td>
                                <td>${patient.telephone}</td>
                                <td>${patient.heurArrivee}</td>
                                <td>
                                    <c:set var="hasActiveConsultation" value="false"/>
                                    <c:set var="hasCompletedConsultation" value="false"/>
                                    <c:if test="${not empty patient.dossierMedical and not empty patient.dossierMedical.consultations}">
                                        <c:forEach items="${patient.dossierMedical.consultations}" var="consult">
                                            <c:if test="${consult.status == 'EN_COURS' or consult.status == 'EN_ATTENTE_AVIS_SPECIALISTE'}">
                                                <c:set var="hasActiveConsultation" value="true"/>
                                            </c:if>
                                            <c:if test="${consult.status == 'TERMINEE'}">
                                                <c:set var="hasCompletedConsultation" value="true"/>
                                            </c:if>
                                        </c:forEach>
                                    </c:if>
                                    
                                    <c:choose>
                                        <c:when test="${hasCompletedConsultation}">
                                            <span class="status-badge status-completed">✓ Terminée</span>
                                        </c:when>
                                        <c:when test="${hasActiveConsultation}">
                                            <span class="status-badge status-consultation">🔴 En Consultation</span>
                                        </c:when>
                                        <c:when test="${patient.fileAttente}">
                                            <span class="status-badge status-waiting">⏳ En Attente</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="status-badge status-waiting">-</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
                </tbody>
            </table>
        </div>
    </div>
</div>

<!-- Add Patient Modal -->
<div id="addPatientModal" class="modal">
    <div class="modal-content">
        <div class="modal-header">
            <h2>Patient Arrival & Registration</h2>
            <button class="close-btn" onclick="closeAddPatientModal()">&times;</button>
        </div>
        <form action="${pageContext.request.contextPath}/dashboard/infermier" method="post">
            <div class="modal-body">
                <!-- Step 1: Administrative Data -->
                <div class="form-section">
                    <h3>1. Administrative Information</h3>
                    <p class="section-description">Patient identity, contact details, social security number, and insurance</p>
                    <div class="form-row">
                        <div class="form-group">
                            <label for="nom">Last Name <span class="required">*</span></label>
                            <input type="text" id="nom" name="nom" >
                        </div>
                        <div class="form-group">
                            <label for="prenom">First Name <span class="required">*</span></label>
                            <input type="text" id="prenom" name="prenom" >
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="form-group">
                            <label for="dateNaissance">Date of Birth <span class="required">*</span></label>
                            <input type="date" id="dateNaissance" name="dateNaissance" >
                        </div>
                        <div class="form-group">
                            <label for="numeroSecuriteSociale">Social Security Number <span class="required">*</span></label>
                            <input type="text" id="numeroSecuriteSociale" name="numeroSecuriteSociale"  placeholder="1234567890123">
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="form-group">
                            <label for="telephone">Phone Number <span class="required">*</span></label>
                            <input type="text" id="telephone" name="telephone"  placeholder="+212 6XX XXX XXX">
                        </div>
                        <div class="form-group">
                            <label for="adresse">Address <span class="required">*</span></label>
                            <input type="text" id="adresse" name="adresse"  placeholder="Street, City">
                        </div>
                    </div>
                    <div class="form-row single">
                        <div class="form-group">
                            <label for="mutuelle">Insurance Company</label>
                            <input type="text" id="mutuelle" name="mutuelle" placeholder="Optional">
                        </div>
                    </div>
                </div>

                <!-- Step 2: Medical History -->
                <div class="form-section">
                    <h3>2. Medical History</h3>
                    <p class="section-description">Medical background, allergies, and current treatments</p>
                    <div class="form-row single">
                        <div class="form-group">
                            <label for="antecedents">Medical History (Antecedents)</label>
                            <textarea id="antecedents" name="antecedents" placeholder="Previous conditions, surgeries, chronic diseases..."></textarea>
                        </div>
                    </div>
                    <div class="form-row single">
                        <div class="form-group">
                            <label for="allergies">Known Allergies</label>
                            <textarea id="allergies" name="allergies" placeholder="Medications, food, environmental allergies..."></textarea>
                        </div>
                    </div>
                    <div class="form-row single">
                        <div class="form-group">
                            <label for="traitementsEnCours">Current Treatments</label>
                            <textarea id="traitementsEnCours" name="traitementsEnCours" placeholder="Current medications, dosages, and treatment plans..."></textarea>
                        </div>
                    </div>
                </div>

                <!-- Step 3: Vital Signs -->
                <div class="form-section">
                    <h3>3. Vital Signs Measurement</h3>
                    <p class="section-description">Measure and record the patient's vital signs</p>

                    <div class="vital-signs-grid">
                        <!-- Blood Pressure -->
                        <div class="vital-sign-card">
                            <label>
                                <span class="vital-sign-icon">🩺</span>
                                Blood Pressure <span class="required">*</span>
                            </label>
                            <div class="input-with-unit">
                                <input type="text" name="tension" placeholder="120/80">
                                <span class="unit">mmHg</span>
                            </div>
                        </div>

                        <!-- Heart Rate -->
                        <div class="vital-sign-card">
                            <label>
                                <span class="vital-sign-icon">❤️</span>
                                Heart Rate <span class="required">*</span>
                            </label>
                            <div class="input-with-unit">
                                <input type="number" name="frequenceCardiaque" placeholder="70"  step="1">
                                <span class="unit">bpm</span>
                            </div>
                        </div>

                        <!-- Temperature -->
                        <div class="vital-sign-card">
                            <label>
                                <span class="vital-sign-icon">🌡️</span>
                                Body Temperature <span class="required">*</span>
                            </label>
                            <div class="input-with-unit">
                                <input type="number" name="temperature"  step="0.1">
                                <span class="unit">°C</span>
                            </div>
                        </div>

                        <!-- Respiratory Rate -->
                        <div class="vital-sign-card">
                            <label>
                                <span class="vital-sign-icon">💨</span>
                                Respiratory Rate <span class="required">*</span>
                            </label>
                            <div class="input-with-unit">
                                <input type="number" name="frequenceRespiratoire" placeholder="16"  step="1">
                                <span class="unit">brpm</span>
                            </div>
                        </div>

                        <!-- Weight -->
                        <div class="vital-sign-card">
                            <label>
                                <span class="vital-sign-icon">⚖️</span>
                                Weight
                            </label>
                            <div class="input-with-unit">
                                <input type="number" name="poids" placeholder="70">
                                <span class="unit">kg</span>
                            </div>
                        </div>

                        <!-- Height -->
                        <div class="vital-sign-card">
                            <label>
                                <span class="vital-sign-icon">📏</span>
                                Height
                            </label>
                            <div class="input-with-unit">
                                <input type="number" name="taille" placeholder="175">
                                <span class="unit">cm</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-cancel" onclick="closeAddPatientModal()">Cancel</button>
                <button type="submit" class="btn btn-primary">Register & Add to Queue</button>
            </div>
        </form>
    </div>
</div>

<!-- View Patient Modal -->
<div id="viewPatientModal" class="modal">
    <div class="modal-content">
        <div class="modal-header">
            <h2>Patient Details</h2>
            <button class="close-btn" onclick="closeViewPatientModal()">&times;</button>
        </div>
        <div class="modal-body">
            <div class="form-section">
                <h3>Personal Information</h3>
                <div class="info-grid">
                    <div class="info-item">
                        <label>Full Name</label>
                        <div class="value" id="view-name"></div>
                    </div>
                    <div class="info-item">
                        <label>Date of Birth</label>
                        <div class="value" id="view-dob"></div>
                    </div>
                    <div class="info-item">
                        <label>Social Security Number</label>
                        <div class="value" id="view-ssn"></div>
                    </div>
                    <div class="info-item">
                        <label>Phone Number</label>
                        <div class="value" id="view-phone"></div>
                    </div>
                    <div class="info-item">
                        <label>Address</label>
                        <div class="value" id="view-address"></div>
                    </div>
                    <div class="info-item">
                        <label>Insurance</label>
                        <div class="value" id="view-insurance"></div>
                    </div>
                </div>
            </div>

            <div class="form-section">
                <h3>Medical History</h3>
                <div class="info-grid" style="grid-template-columns: 1fr;">
                    <div class="info-item">
                        <label>Medical History</label>
                        <div class="value" id="view-antecedents"></div>
                    </div>
                    <div class="info-item">
                        <label>Allergies</label>
                        <div class="value" id="view-allergies"></div>
                    </div>
                    <div class="info-item">
                        <label>Current Treatments</label>
                        <div class="value" id="view-traitementsEnCours"></div>
                    </div>
                </div>
            </div>

            <div class="form-section">
                <h3>Vital Signs</h3>
                <div id="vital-signs-container">
                    <p style="color: #6b7280; font-size: 14px;">No vital signs recorded yet for this consultation.</p>
                </div>
            </div>

            <div class="form-section" style="border-bottom: none;">
                <h3>Status Information</h3>
                <div class="info-grid">
                    <div class="info-item">
                        <label>Arrival Time</label>
                        <div class="value" id="view-arrival"></div>
                    </div>
                    <div class="info-item">
                        <label>Current Status</label>
                        <div class="value" id="view-status"></div>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-primary" id="startConsultationBtn" style="display:none;">Start Consultation</button>
            <button type="button" class="btn btn-secondary" onclick="closeViewPatientModal()">Close</button>
        </div>
    </div>
</div>

<script>
    // Function to open the Add Patient Modal
    function openAddPatientModal() {
        document.getElementById('addPatientModal').classList.add('active');
        // Clear previous form data if any
        document.querySelector('#addPatientModal form').reset();
    }

    // Function to close the Add Patient Modal
    function closeAddPatientModal() {
        document.getElementById('addPatientModal').classList.remove('active');
    }

    // Function to open the View Patient Modal and populate data
    function viewPatient(patientData) {
        console.log("Viewing patient:", patientData); // Debugging

        document.getElementById('view-name').textContent = patientData.nom + ' ' + patientData.prenom;
        document.getElementById('view-dob').textContent = patientData.dateNaissance;
        document.getElementById('view-ssn').textContent = patientData.numeroSecuriteSociale;
        document.getElementById('view-phone').textContent = patientData.telephone;
        document.getElementById('view-address').textContent = patientData.adresse;
        document.getElementById('view-insurance').textContent = patientData.mutuelle || 'N/A';

        // Medical History
        if (patientData.dossierMedical) {
            document.getElementById('view-antecedents').textContent = patientData.dossierMedical.antecedents || 'N/A';
            document.getElementById('view-allergies').textContent = patientData.dossierMedical.allergies || 'N/A';
            document.getElementById('view-traitementsEnCours').textContent = patientData.dossierMedical.traitementsEnCours || 'N/A';
        } else {
            document.getElementById('view-antecedents').textContent = 'N/A';
            document.getElementById('view-allergies').textContent = 'N/A';
            document.getElementById('view-traitementsEnCours').textContent = 'N/A';
        }


        // Vital Signs - Display the latest vital signs from the patient's medical record
        const vitalSignsContainer = document.getElementById('vital-signs-container');
        vitalSignsContainer.innerHTML = ''; // Clear previous vital signs

        if (patientData.dossierMedical && patientData.dossierMedical.consultations && patientData.dossierMedical.consultations.length > 0) {
            // Get the latest consultation (assuming the last one in the list is the most recent)
            const latestConsultation = patientData.dossierMedical.consultations[patientData.dossierMedical.consultations.length - 1];
            const vitalSigns = latestConsultation.signesVitaux;

            if (vitalSigns) {
                const vitalSignsHtml = `
                    <div class="vital-signs-display">
                        <div class="vital-display-card">
                            <label>Blood Pressure</label>
                            <div class="value">${vitalSigns.tension || 'N/A'} mmHg</div>
                        </div>
                        <div class="vital-display-card">
                            <label>Heart Rate</label>
                            <div class="value">${vitalSigns.frequenceCardiaque || 'N/A'} bpm</div>
                        </div>
                        <div class="vital-display-card">
                            <label>Temperature</label>
                            <div class="value">${vitalSigns.temperature || 'N/A'} °C</div>
                        </div>
                        <div class="vital-display-card">
                            <label>Respiratory Rate</label>
                            <div class="value">${vitalSigns.frequenceRespiratoire || 'N/A'} brpm</div>
                        </div>
                        <div class="vital-display-card">
                            <label>Weight</label>
                            <div class="value">${vitalSigns.poids ? vitalSigns.poids + ' kg' : 'N/A'}</div>
                        </div>
                        <div class="vital-display-card">
                            <label>Height</label>
                            <div class="value">${vitalSigns.taille ? vitalSigns.taille + ' cm' : 'N/A'}</div>
                        </div>
                    </div>
                    <p style="color: #6b7280; font-size: 13px; margin-top: 15px;">
                        Recorded on: ${vitalSigns.dateSaisie || 'N/A'}
                    </p>
                `;
                vitalSignsContainer.innerHTML = vitalSignsHtml;
            } else {
                vitalSignsContainer.innerHTML = '<p style="color: #6b7280; font-size: 14px;">No vital signs recorded yet for this consultation.</p>';
            }
        } else {
            vitalSignsContainer.innerHTML = '<p style="color: #6b7280; font-size: 14px;">No vital signs recorded yet for this patient.</p>';
        }


        // Status Information
        document.getElementById('view-arrival').textContent = patientData.heurArrivee;
        let statusText = '';
        let startConsultationBtn = document.getElementById('startConsultationBtn');
        startConsultationBtn.style.display = 'none'; // Hide by default

        // Check consultation status
        let hasActiveConsultation = false;
        let hasCompletedConsultation = false;
        
        if (patientData.dossierMedical && patientData.dossierMedical.consultations) {
            patientData.dossierMedical.consultations.forEach(function(consult) {
                if (consult.status === 'EN_COURS' || consult.status === 'EN_ATTENTE_AVIS_SPECIALISTE') {
                    hasActiveConsultation = true;
                }
                if (consult.status === 'TERMINEE') {
                    hasCompletedConsultation = true;
                }
            });
        }
        
        if (hasCompletedConsultation) {
            statusText = '<span class="status-badge status-completed">✓ Terminée</span>';
        } else if (hasActiveConsultation) {
            statusText = '<span class="status-badge status-consultation">🔴 En Consultation</span>';
        } else if (patientData.fileAttente) {
            statusText = '<span class="status-badge status-waiting">⏳ En Attente</span>';
            // If patient is waiting, offer to start consultation
            startConsultationBtn.style.display = 'inline-flex';
            startConsultationBtn.onclick = function() {
                // Redirect or submit form to start consultation
                window.location.href = '${pageContext.request.contextPath}/nurse/consultation/start?patientId=' + patientData.id;
            };
        } else {
            statusText = '<span class="status-badge status-waiting">-</span>';
        }
        document.getElementById('view-status').innerHTML = statusText;

        document.getElementById('viewPatientModal').classList.add('active');
    }

    // Function to close the View Patient Modal
    function closeViewPatientModal() {
        document.getElementById('viewPatientModal').classList.remove('active');
    }

    // Check for success/error messages on page load and display modals if needed
    window.onload = function() {
        const urlParams = new URLSearchParams(window.location.search);
        if (urlParams.get('showAddPatientModal') === 'true') {
            openAddPatientModal();
        }
        // Example for showing the view modal after an action, if needed
        // if (urlParams.get('showViewPatientModal') === 'true' && urlParams.get('patientData')) {
        //     const patientData = JSON.parse(decodeURIComponent(urlParams.get('patientData')));
        //     viewPatient(patientData);
        // }
    };

</script>
</body>
</html>

