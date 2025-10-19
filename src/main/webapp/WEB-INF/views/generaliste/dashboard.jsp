<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard Généraliste - Medical Platform</title>
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
            margin-bottom: 32px;
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

        .status-en-cours {
            background-color: #dbeafe;
            color: #1e40af;
        }

        .status-attente-avis {
            background-color: #fce7f3;
            color: #9f1239;
        }

        .status-completed {
            background-color: #d1fae5;
            color: #065f46;
        }

        .action-btn {
            padding: 8px 16px;
            border-radius: 4px;
            border: none;
            background-color: #3b82f6;
            color: #ffffff;
            cursor: pointer;
            font-size: 13px;
            font-weight: 500;
            transition: all 0.15s;
        }

        .action-btn:hover {
            background-color: #2563eb;
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

            .stats-grid {
                grid-template-columns: 1fr;
            }

            table {
                font-size: 12px;
            }

            th, td {
                padding: 12px;
            }
        }
    </style>
</head>
<body>
    <!-- Header -->
    <div class="header">
        <h1>👨‍⚕️ Dashboard Généraliste</h1>
        <div class="header-actions">
            <span style="color: #6b7280; font-size: 14px;">Bienvenue, Dr. ${sessionScope.user.prenom} ${sessionScope.user.nom}</span>
            <form action="${pageContext.request.contextPath}/auth/logout" method="post" style="margin: 0;">
                <button type="submit" class="btn btn-secondary">Déconnexion</button>
            </form>
        </div>
    </div>

    <!-- Main Container -->
    <div class="container">
        <!-- Success/Error Messages -->
        <c:if test="${not empty sessionScope.successMessage}">
            <div class="alert alert-success">${sessionScope.successMessage}</div>
            <c:remove var="successMessage" scope="session" />
        </c:if>

        <c:if test="${not empty requestScope.errorMessage}">
            <div class="alert alert-error">${requestScope.errorMessage}</div>
        </c:if>

        <!-- Stats Cards -->
        <div class="stats-grid">
            <div class="stat-card">
                <h3>Patients en Attente</h3>
                <div class="value" style="color: #f59e0b;">${not empty patients ? patients.size() : 0}</div>
            </div>
            <div class="stat-card">
                <h3>Consultations Aujourd'hui</h3>
                <div class="value" style="color: #3b82f6;">${not empty todayCount ? todayCount : 0}</div>
            </div>
            <div class="stat-card">
                <h3>Total Consultations</h3>
                <div class="value">${not empty consultations ? consultations.size() : 0}</div>
            </div>
        </div>

        <!-- Waiting Patients Section -->
        <div class="patient-section">
            <div class="section-header">
                <h2>🏥 Patients en File d'Attente</h2>
            </div>

            <div class="table-container">
                <table>
                    <thead>
                        <tr>
                            <th>Nom du Patient</th>
                            <th>Email</th>
                            <th>Téléphone</th>
                            <th>Date de Naissance</th>
                            <th>Groupe Sanguin</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${empty patients}">
                                <tr>
                                    <td colspan="6" style="text-align: center; color: #6b7280; padding: 40px;">
                                        😊 Aucun patient en attente pour le moment
                                    </td>
                                </tr>
                            </c:when>
                            <c:otherwise>
                                <c:forEach items="${patients}" var="patient">
                                    <tr>
                                        <td><strong>${patient.nom} ${patient.prenom}</strong></td>
                                        <td>${patient.email}</td>
                                        <td>${patient.telephone}</td>
                                        <td>${patient.dateNaissance}</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${not empty patient.dossierMedical and not empty patient.dossierMedical.groupeSanguin}">
                                                    <span style="font-weight: 600; color: #dc2626;">🩸 ${patient.dossierMedical.groupeSanguin}</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span style="color: #9ca3af;">-</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <form action="${pageContext.request.contextPath}/dashboard/generaliste" method="post" style="display: inline;">
                                                <input type="hidden" name="action" value="startConsultation">
                                                <input type="hidden" name="patientId" value="${patient.id}">
                                                <button type="submit" class="action-btn">▶️ Commencer Consultation</button>
                                            </form>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- Recent Consultations Section -->
        <div class="patient-section">
            <div class="section-header">
                <h2>📋 Mes Consultations Récentes</h2>
            </div>

            <div class="table-container">
                <table>
                    <thead>
                        <tr>
                            <th>Date</th>
                            <th>Patient</th>
                            <th>Motif</th>
                            <th>Diagnostic</th>
                            <th>Statut</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${empty consultations}">
                                <tr>
                                    <td colspan="6" style="text-align: center; color: #6b7280; padding: 40px;">
                                        📋 Aucune consultation enregistrée
                                    </td>
                                </tr>
                            </c:when>
                            <c:otherwise>
                                <c:forEach items="${consultations}" var="consult" varStatus="status">
                                    <c:if test="${status.index < 10}">
                                        <tr>
                                            <td>${consult.dateConsultation}</td>
                                            <td>
                                                <c:if test="${not empty consult.dossierMedical and not empty consult.dossierMedical.patient}">
                                                    <strong>${consult.dossierMedical.patient.nom} ${consult.dossierMedical.patient.prenom}</strong>
                                                </c:if>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${not empty consult.motif}">
                                                        ${fn:substring(consult.motif, 0, 50)}${fn:length(consult.motif) > 50 ? '...' : ''}
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span style="color: #9ca3af;">-</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${not empty consult.diagnostic}">
                                                        ${fn:substring(consult.diagnostic, 0, 40)}${fn:length(consult.diagnostic) > 40 ? '...' : ''}
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span style="color: #9ca3af;">-</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${consult.status == 'EN_COURS'}">
                                                        <span class="status-badge status-en-cours">En cours</span>
                                                    </c:when>
                                                    <c:when test="${consult.status == 'TERMINEE'}">
                                                        <span class="status-badge status-completed">Terminée</span>
                                                    </c:when>
                                                    <c:when test="${consult.status == 'EN_ATTENTE_AVIS_SPECIALISTE'}">
                                                        <span class="status-badge status-attente-avis">Attente avis</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="status-badge status-waiting">${consult.status}</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <c:if test="${consult.status != 'TERMINEE'}">
                                                    <a href="${pageContext.request.contextPath}/dashboard/generaliste/consultation?id=${consult.id}" 
                                                       class="action-btn" style="text-decoration: none;">
                                                        👁️ Voir Détails
                                                    </a>
                                                </c:if>
                                            </td>
                                        </tr>
                                    </c:if>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</body>
</html>
