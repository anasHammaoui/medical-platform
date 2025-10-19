<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sélection Spécialiste - Généraliste</title>
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

        .container {
            max-width: 1400px;
            margin: 0 auto;
            padding: 40px;
        }

        .section {
            background-color: #ffffff;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
            border: 1px solid #e5e7eb;
            padding: 24px;
            margin-bottom: 24px;
        }

        .section h2 {
            color: #1f2937;
            font-size: 18px;
            font-weight: 600;
            margin-bottom: 20px;
            border-bottom: 2px solid #3b82f6;
            padding-bottom: 10px;
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

        .patient-info-bar {
            background-color: #f9fafb;
            padding: 16px;
            border-radius: 6px;
            border-left: 4px solid #3b82f6;
            margin-bottom: 24px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .patient-name {
            color: #1f2937;
            font-size: 18px;
            font-weight: 600;
        }

        .consultation-info {
            color: #6b7280;
            font-size: 14px;
            margin-top: 4px;
        }

        .specialiste-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }

        .specialiste-card {
            background-color: #ffffff;
            border: 2px solid #e5e7eb;
            border-radius: 8px;
            padding: 20px;
            cursor: pointer;
            transition: all 0.15s;
            position: relative;
        }

        .specialiste-card:hover {
            border-color: #3b82f6;
            box-shadow: 0 4px 12px rgba(59, 130, 246, 0.15);
            transform: translateY(-2px);
        }

        .specialiste-card.selected {
            border-color: #3b82f6;
            background-color: #eff6ff;
            box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.1);
        }

        .specialiste-card.selected::before {
            content: "✓";
            position: absolute;
            top: 10px;
            right: 10px;
            background-color: #3b82f6;
            color: white;
            width: 24px;
            height: 24px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 14px;
            font-weight: bold;
        }

        .specialiste-name {
            color: #1f2937;
            font-size: 16px;
            font-weight: 600;
            margin-bottom: 8px;
        }

        .specialiste-specialite {
            color: #3b82f6;
            font-size: 13px;
            font-weight: 600;
            margin-bottom: 12px;
        }

        .specialiste-email,
        .specialiste-phone {
            color: #6b7280;
            font-size: 13px;
            margin-bottom: 6px;
            display: flex;
            align-items: center;
            gap: 6px;
        }

        .disponibilites-label {
            color: #374151;
            font-size: 14px;
            font-weight: 600;
            margin-top: 16px;
            margin-bottom: 8px;
        }

        .creneau-grid {
            display: none;
            grid-template-columns: repeat(2, 1fr);
            gap: 8px;
            margin-top: 12px;
        }

        .creneau-grid.active {
            display: grid;
        }

        .creneau-btn {
            padding: 10px;
            border-radius: 6px;
            border: 1px solid #d1d5db;
            background-color: #ffffff;
            cursor: pointer;
            font-size: 13px;
            font-weight: 500;
            color: #374151;
            transition: all 0.15s;
            text-align: center;
        }

        .creneau-btn:hover {
            border-color: #3b82f6;
            background-color: #eff6ff;
        }

        .creneau-btn.selected {
            background-color: #3b82f6;
            color: #ffffff;
            border-color: #3b82f6;
        }

        .creneau-btn.unavailable {
            opacity: 0.4;
            cursor: not-allowed;
            background-color: #f3f4f6;
        }

        .creneau-btn.unavailable:hover {
            border-color: #d1d5db;
            background-color: #f3f4f6;
        }

        .form-section {
            margin-top: 30px;
            padding-top: 30px;
            border-top: 2px dashed #e5e7eb;
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

        .form-group textarea {
            width: 100%;
            padding: 10px 12px;
            border-radius: 6px;
            border: 1px solid #d1d5db;
            font-size: 14px;
            color: #1f2937;
            font-family: inherit;
            resize: vertical;
            min-height: 100px;
            transition: border-color 0.15s, box-shadow 0.15s;
        }

        .form-group textarea:focus {
            outline: none;
            border-color: #3b82f6;
            box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.1);
        }

        .checkbox-group {
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .checkbox-group input[type="checkbox"] {
            width: 18px;
            height: 18px;
            cursor: pointer;
        }

        .checkbox-group label {
            color: #374151;
            font-size: 14px;
            cursor: pointer;
            font-weight: 500;
        }

        .submit-section {
            display: flex;
            gap: 12px;
        }

        .btn-submit {
            flex: 1;
            padding: 14px;
            font-size: 15px;
            font-weight: 600;
        }

        .empty-state {
            text-align: center;
            padding: 60px 20px;
            color: #6b7280;
        }

        .empty-state-icon {
            font-size: 48px;
            margin-bottom: 16px;
        }

        @media (max-width: 768px) {
            .container {
                padding: 20px;
            }

            .specialiste-grid {
                grid-template-columns: 1fr;
            }

            .creneau-grid {
                grid-template-columns: 1fr;
            }

            .submit-section {
                flex-direction: column;
            }
        }
    </style>
</head>
<body>
    <div class="header">
        <h1>👨‍⚕️ Sélection Spécialiste</h1>
        <a href="${pageContext.request.contextPath}/dashboard/generaliste/consultation?id=${consultationId}" class="btn btn-secondary">
            ← Retour à la Consultation
        </a>
    </div>

    <div class="container">
        <!-- Patient Info -->
        <div class="patient-info-bar">
            <div>
                <div class="patient-name">
                    👤 ${patientName}
                </div>
                <div class="consultation-info">
                    Consultation #${consultationId} - Spécialité: <strong>${specialite}</strong>
                </div>
            </div>
        </div>

        <!-- Form -->
        <form id="expertiseForm" action="${pageContext.request.contextPath}/dashboard/generaliste/expertise" method="post">
            <input type="hidden" name="consultationId" value="${consultationId}">
            <input type="hidden" name="specialiteId" id="selectedSpecialisteId">
            <input type="hidden" name="creneauId" id="selectedCreneauId">

            <div class="section">
                <h2>📋 Informations de la Demande</h2>
                
                <div class="alert alert-info">
                    💡 Sélectionnez un spécialiste disponible, choisissez un créneau horaire, puis soumettez la demande d'expertise.
                </div>

                <div class="form-group">
                    <label>Motif de la demande d'expertise *</label>
                    <textarea name="motif" required placeholder="Décrivez la raison pour laquelle vous demandez l'avis d'un spécialiste..."></textarea>
                </div>

                <div class="checkbox-group">
                    <input type="checkbox" id="prioritaire" name="prioritaire" value="true">
                    <label for="prioritaire">⚠️ Marquer cette demande comme prioritaire</label>
                </div>
            </div>

            <!-- Specialists Grid -->
            <div class="section">
                <h2>👨‍⚕️ Spécialistes Disponibles</h2>

                <c:choose>
                    <c:when test="${not empty specialistes}">
                        <div class="specialiste-grid">
                            <c:forEach items="${specialistes}" var="spec">
                                <div class="specialiste-card" onclick="selectSpecialiste(${spec.id})">
                                    <div class="specialiste-name">
                                        Dr. ${spec.nom} ${spec.prenom}
                                    </div>
                                    <div class="specialiste-specialite">
                                        ${spec.specialite}
                                    </div>
                                    <div class="specialiste-email">
                                        📧 ${spec.email}
                                    </div>
                                    <div class="specialiste-phone">
                                        📞 ${spec.telephone}
                                    </div>
                                    
                                    <div class="disponibilites-label">Créneaux disponibles:</div>
                                    <div class="creneau-grid" id="creneaux-${spec.id}">
                                        <c:forEach items="${spec.creneaux}" var="creneau">
                                            <c:choose>
                                                <c:when test="${creneau.disponible}">
                                                    <button type="button" 
                                                            class="creneau-btn" 
                                                            data-creneau-id="${creneau.id}"
                                                            onclick="selectCreneau(event, ${spec.id}, ${creneau.id})">
                                                        ${creneau.jour} - ${creneau.heureDebut}
                                                    </button>
                                                </c:when>
                                                <c:otherwise>
                                                    <button type="button" 
                                                            class="creneau-btn unavailable" 
                                                            disabled>
                                                        ${creneau.jour} - ${creneau.heureDebut} (Occupé)
                                                    </button>
                                                </c:otherwise>
                                            </c:choose>
                                        </c:forEach>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="empty-state">
                            <div class="empty-state-icon">😔</div>
                            <p>Aucun spécialiste disponible pour cette spécialité pour le moment.</p>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>

            <!-- Submit Buttons -->
            <c:if test="${not empty specialistes}">
                <div class="submit-section">
                    <button type="submit" class="btn btn-primary btn-submit" id="submitBtn" disabled>
                        📤 Soumettre la Demande d'Expertise
                    </button>
                    <a href="${pageContext.request.contextPath}/dashboard/generaliste/consultation?id=${consultationId}" 
                       class="btn btn-secondary btn-submit">
                        ❌ Annuler
                    </a>
                </div>
            </c:if>
        </form>
    </div>

    <script>
        let selectedSpecialisteId = null;
        let selectedCreneauId = null;

        function selectSpecialiste(specialisteId) {
            // Remove all selections
            document.querySelectorAll('.specialiste-card').forEach(card => {
                card.classList.remove('selected');
            });
            document.querySelectorAll('.creneau-grid').forEach(grid => {
                grid.classList.remove('active');
            });
            
            // Select the clicked specialiste
            const clickedCard = event.currentTarget;
            clickedCard.classList.add('selected');
            
            // Show creneaux for this specialiste
            const creneauxGrid = document.getElementById('creneaux-' + specialisteId);
            if (creneauxGrid) {
                creneauxGrid.classList.add('active');
            }
            
            selectedSpecialisteId = specialisteId;
            selectedCreneauId = null;
            
            // Clear creneau selection
            document.querySelectorAll('.creneau-btn').forEach(btn => {
                btn.classList.remove('selected');
            });
            
            updateSubmitButton();
        }

        function selectCreneau(event, specialisteId, creneauId) {
            event.stopPropagation();
            
            // Remove all creneau selections for this specialiste
            const creneauxGrid = document.getElementById('creneaux-' + specialisteId);
            creneauxGrid.querySelectorAll('.creneau-btn').forEach(btn => {
                btn.classList.remove('selected');
            });
            
            // Select the clicked creneau
            event.currentTarget.classList.add('selected');
            selectedCreneauId = creneauId;
            
            updateSubmitButton();
        }

        function updateSubmitButton() {
            const submitBtn = document.getElementById('submitBtn');
            const specialisteInput = document.getElementById('selectedSpecialisteId');
            const creneauInput = document.getElementById('selectedCreneauId');
            
            if (selectedSpecialisteId && selectedCreneauId) {
                submitBtn.disabled = false;
                specialisteInput.value = selectedSpecialisteId;
                creneauInput.value = selectedCreneauId;
            } else {
                submitBtn.disabled = true;
            }
        }

        // Prevent form submission if no selections
        document.getElementById('expertiseForm').addEventListener('submit', function(e) {
            if (!selectedSpecialisteId || !selectedCreneauId) {
                e.preventDefault();
                alert('⚠️ Veuillez sélectionner un spécialiste et un créneau horaire.');
            }
        });
    </script>
</body>
</html>
