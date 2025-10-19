<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Consultation - Généraliste</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }

        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, 'Helvetica Neue', Arial, sans-serif;
            background-color: #f5f7fa;
            min-height: 100vh;
        }

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

        .btn {
            padding: 10px 20px;
            border-radius: 6px;
            border: none;
            cursor: pointer;
            font-size: 14px;
            font-weight: 500;
            transition: all 0.15s;
            text-decoration: none;
            display: inline-block;
        }

        .btn-secondary {
            background-color: #6b7280;
            color: #ffffff;
        }

        .btn-secondary:hover {
            background-color: #4b5563;
        }

        .btn-primary {
            background-color: #3b82f6;
            color: #ffffff;
        }

        .btn-primary:hover {
            background-color: #2563eb;
        }

        .btn-success {
            background-color: #10b981;
            color: #ffffff;
        }

        .btn-success:hover {
            background-color: #059669;
        }

        .btn-warning {
            background-color: #f59e0b;
            color: #ffffff;
        }

        .btn-warning:hover {
            background-color: #d97706;
        }

        .container {
            max-width: 1400px;
            margin: 0 auto;
            padding: 40px;
        }

        .content-grid {
            display: grid;
            grid-template-columns: 350px 1fr;
            gap: 24px;
        }

        .section {
            background-color: #ffffff;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
            border: 1px solid #e5e7eb;
            padding: 24px;
        }

        .section h2 {
            color: #1f2937;
            font-size: 18px;
            font-weight: 600;
            margin-bottom: 20px;
            border-bottom: 2px solid #3b82f6;
            padding-bottom: 10px;
        }

        .info-item {
            padding: 12px;
            background-color: #f9fafb;
            border-radius: 6px;
            margin-bottom: 12px;
            border-left: 3px solid #3b82f6;
        }

        .info-label {
            color: #6b7280;
            font-size: 12px;
            font-weight: 600;
            text-transform: uppercase;
            margin-bottom: 4px;
        }

        .info-value {
            color: #1f2937;
            font-size: 14px;
            font-weight: 500;
        }

        .vital-signs-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 12px;
            margin-top: 12px;
        }

        .vital-card {
            background-color: #eff6ff;
            padding: 12px;
            border-radius: 6px;
            border: 1px solid #bfdbfe;
            text-align: center;
        }

        .vital-label {
            color: #1e40af;
            font-size: 11px;
            font-weight: 600;
            text-transform: uppercase;
            margin-bottom: 4px;
        }

        .vital-value {
            color: #1e3a8a;
            font-size: 18px;
            font-weight: 700;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            color: #374151;
            font-weight: 600;
            margin-bottom: 8px;
            font-size: 14px;
        }

        .form-group input,
        .form-group textarea,
        .form-group select {
            width: 100%;
            padding: 10px 12px;
            border-radius: 6px;
            border: 1px solid #d1d5db;
            font-size: 14px;
            color: #1f2937;
            font-family: inherit;
            transition: border-color 0.15s, box-shadow 0.15s;
        }

        .form-group textarea {
            resize: vertical;
            min-height: 100px;
        }

        .form-group input:focus,
        .form-group textarea:focus,
        .form-group select:focus {
            outline: none;
            border-color: #3b82f6;
            box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.1);
        }

        .status-badge {
            display: inline-block;
            padding: 6px 14px;
            border-radius: 20px;
            font-size: 13px;
            font-weight: 600;
            margin-bottom: 16px;
        }

        .status-en-cours {
            background-color: #fef3c7;
            color: #92400e;
        }

        .alert {
            padding: 12px 16px;
            border-radius: 6px;
            margin-bottom: 20px;
            font-size: 14px;
            border: 1px solid;
        }

        .alert-info {
            background-color: #eff6ff;
            color: #1e40af;
            border-color: #bfdbfe;
        }

        .form-separator {
            margin: 30px 0;
            border: 0;
            border-top: 2px dashed #e5e7eb;
        }

        .form-section-title {
            color: #1f2937;
            font-size: 16px;
            font-weight: 600;
            margin-bottom: 16px;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        @media (max-width: 768px) {
            .container {
                padding: 20px;
            }

            .content-grid {
                grid-template-columns: 1fr;
            }

            .vital-signs-grid {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
    <div class="header">
        <h1>📋 Consultation en Cours</h1>
        <a href="${pageContext.request.contextPath}/dashboard/generaliste" class="btn btn-secondary">
            ← Retour au Dashboard
        </a>
    </div>

    <div class="container">
        <div class="content-grid">
            <!-- Patient Info Sidebar -->
            <div>
                <div class="section">
                    <h2>👤 Informations Patient</h2>
                    <div class="info-item">
                        <div class="info-label">Nom complet</div>
                        <div class="info-value">
                            ${consultation.dossierMedical.patient.nom} ${consultation.dossierMedical.patient.prenom}
                        </div>
                    </div>
                    <div class="info-item">
                        <div class="info-label">Date de naissance</div>
                        <div class="info-value">${consultation.dossierMedical.patient.dateNaissance}</div>
                    </div>
                    <div class="info-item">
                        <div class="info-label">Email</div>
                        <div class="info-value">${consultation.dossierMedical.patient.email}</div>
                    </div>
                    <div class="info-item">
                        <div class="info-label">Téléphone</div>
                        <div class="info-value">${consultation.dossierMedical.patient.telephone}</div>
                    </div>
                    <c:if test="${not empty consultation.dossierMedical.groupeSanguin}">
                        <div class="info-item">
                            <div class="info-label">Groupe sanguin</div>
                            <div class="info-value">🩸 ${consultation.dossierMedical.groupeSanguin}</div>
                        </div>
                    </c:if>
                    <c:if test="${not empty consultation.dossierMedical.allergies}">
                        <div class="info-item">
                            <div class="info-label">Allergies</div>
                            <div class="info-value" style="color: #dc2626;">⚠️ ${consultation.dossierMedical.allergies}</div>
                        </div>
                    </c:if>
                </div>

                <!-- Vital Signs -->
                <c:if test="${not empty consultation.dossierMedical.signesVitaux}">
                    <div class="section" style="margin-top: 20px;">
                        <h2>💓 Signes Vitaux</h2>
                        <div class="vital-signs-grid">
                            <c:if test="${not empty consultation.dossierMedical.signesVitaux.tension}">
                                <div class="vital-card">
                                    <div class="vital-label">Tension</div>
                                    <div class="vital-value">${consultation.dossierMedical.signesVitaux.tension}</div>
                                </div>
                            </c:if>
                            <c:if test="${not empty consultation.dossierMedical.signesVitaux.temperature}">
                                <div class="vital-card">
                                    <div class="vital-label">Température</div>
                                    <div class="vital-value">${consultation.dossierMedical.signesVitaux.temperature}°C</div>
                                </div>
                            </c:if>
                            <c:if test="${not empty consultation.dossierMedical.signesVitaux.frequenceCardiaque}">
                                <div class="vital-card">
                                    <div class="vital-label">Pouls</div>
                                    <div class="vital-value">${consultation.dossierMedical.signesVitaux.frequenceCardiaque} bpm</div>
                                </div>
                            </c:if>
                            <c:if test="${not empty consultation.dossierMedical.signesVitaux.frequenceRespiratoire}">
                                <div class="vital-card">
                                    <div class="vital-label">Fréq. Resp.</div>
                                    <div class="vital-value">${consultation.dossierMedical.signesVitaux.frequenceRespiratoire}</div>
                                </div>
                            </c:if>
                        </div>
                    </div>
                </c:if>
            </div>

            <!-- Consultation Form -->
            <div class="section">
                <span class="status-badge status-en-cours">🔴 En Cours</span>

                <div class="alert alert-info">
                    💡 Remplissez les informations de consultation. Vous pouvez soit terminer directement la consultation, 
                    soit demander l'avis d'un spécialiste.
                </div>

                <!-- Save Observations Form -->
                <form action="${pageContext.request.contextPath}/dashboard/generaliste/consultation" method="post">
                    <input type="hidden" name="action" value="saveObservations">
                    <input type="hidden" name="consultationId" value="${consultation.id}">

                    <div class="form-section-title">📝 Observations</div>

                    <div class="form-group">
                        <label>Motif de consultation *</label>
                        <textarea name="motif" required>${consultation.motif}</textarea>
                    </div>

                    <div class="form-group">
                        <label>Observations cliniques *</label>
                        <textarea name="observations" required>${consultation.observations}</textarea>
                    </div>

                    <button type="submit" class="btn btn-primary" style="width: 100%;">
                        💾 Sauvegarder les Observations
                    </button>
                </form>

                <hr class="form-separator">

                <!-- Complete Consultation Form -->
                <form action="${pageContext.request.contextPath}/dashboard/generaliste/consultation" method="post">
                    <input type="hidden" name="action" value="complete">
                    <input type="hidden" name="consultationId" value="${consultation.id}">

                    <div class="form-section-title">✅ Terminer la Consultation</div>

                    <div class="form-group">
                        <label>Diagnostic *</label>
                        <textarea name="diagnostic" required>${consultation.diagnostic}</textarea>
                    </div>

                    <div class="form-group">
                        <label>Traitement prescrit *</label>
                        <textarea name="traitement" required>${consultation.traitement}</textarea>
                    </div>

                    <button type="submit" class="btn btn-success" style="width: 100%;">
                        ✅ Terminer la Consultation
                    </button>
                </form>

                <hr class="form-separator">

                <!-- Request Specialist Form -->
                <form action="${pageContext.request.contextPath}/dashboard/generaliste/consultation" method="post">
                    <input type="hidden" name="action" value="requestSpecialist">
                    <input type="hidden" name="consultationId" value="${consultation.id}">

                    <div class="form-section-title">👨‍⚕️ Demander un Avis Spécialisé</div>

                    <div class="form-group">
                        <label>Spécialité médicale *</label>
                        <select name="specialite" required>
                            <option value="">-- Sélectionner une spécialité --</option>
                            <c:forEach var="spec" items="${specialites}">
                                <option value="${spec}">${spec}</option>
                            </c:forEach>
                        </select>
                    </div>

                    <button type="submit" class="btn btn-warning" style="width: 100%;">
                        📤 Rechercher des Spécialistes
                    </button>
                </form>
            </div>
        </div>
    </div>
</body>
</html>
