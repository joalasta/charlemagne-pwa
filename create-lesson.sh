#!/bin/bash

# Vérifier si un argument a été fourni
if [ $# -eq 0 ]; then
    echo "Usage: ./create-lesson.sh <nom-du-chapitre>"
    echo "Exemple: ./create-lesson.sh vikings"
    exit 1
fi

# Nom du chapitre (en minuscules, sans espaces)
CHAPTER=$1

# Créer le fichier HTML
cat > "chapitre-${CHAPTER}.html" << EOL
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Les ${CHAPTER^} - Histoire CM1</title>
    
    <!-- PWA Meta tags -->
    <meta name="theme-color" content="#2463EB">
    <meta name="description" content="Découvre l'histoire des ${CHAPTER^} !">
    <link rel="manifest" href="manifest.json">
    <link rel="icon" type="image/png" sizes="192x192" href="icon-192.png">
    <link rel="apple-touch-icon" href="icon-192.png">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="default">
    <meta name="apple-mobile-web-app-title" content="${CHAPTER^} App">
    <link rel="stylesheet" href="navigation.css">
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <!-- Navigation principale -->
    <nav class="main-nav">
        <a href="index.html" class="nav-back">← Accueil</a>
        <div class="nav-center">
            <h2 class="nav-title"></h2>
            <div class="score-live" id="liveScore">Score: 0/5</div>
        </div>
        <button class="reset-quiz nav-reset" onclick="resetQuiz()">🔄</button>
    </nav>

    <!-- Contenu principal -->
    <main class="main-content">
        <!-- Page d'accueil -->
        <div id="home" class="page active">
            <div class="home-page">
                <div class="charlemagne-container">
                    <img src="images/${CHAPTER}-icon.png" alt="${CHAPTER^}" class="charlemagne-image">
                </div>
                <h1>Les ${CHAPTER^}</h1>
                <p class="subtitle">Description à personnaliser</p>
                
                <div class="menu-grid">
                    <div class="menu-card" onclick="showPage('lesson')">
                        <div class="icon">
                            <img src="icons/book.svg" alt="Livres" class="icon-img">
                        </div>
                        <h3>La Leçon</h3>
                    </div>
                    
                    <div class="menu-card" onclick="showPage('quiz')">
                        <div class="icon">
                            <img src="icons/brain.svg" alt="Cible" class="icon-img">
                        </div>
                        <h3>Quiz</h3>
                    </div>
                    
                    <div class="menu-card" onclick="showPage('timeline')">
                        <div class="icon">
                            <img src="icons/calendar.svg" alt="Calendrier" class="icon-img">
                        </div>
                        <h3>Chronologie</h3>
                    </div>
                </div>
            </div>
        </div>

        <!-- Page Leçon -->
        <div id="lesson" class="page">
            <div class="content-wrapper">
                <div class="lesson-content">
                    <h2>Les ${CHAPTER^}</h2>
                    
                    <h3>1. Premier titre</h3>
                    <p>Premier paragraphe...</p>
                    <p>Date importante : <span class="date-important">DATE av. J.-C.</span></p>
                    
                    <h3>2. Deuxième titre</h3>
                    <p>Deuxième paragraphe...</p>
                    
                    <h3>3. Troisième titre</h3>
                    <p>Troisième paragraphe...</p>
                    
                    <h3>📖 À retenir</h3>
                    <ul>
                        <li><strong>Date 1</strong> : Événement 1</li>
                        <li><strong>Date 2</strong> : Événement 2</li>
                        <li><strong>Date 3</strong> : Événement 3</li>
                    </ul>
                </div>
            </div>
        </div>

        <!-- Page Quiz -->
        <div id="quiz" class="page">
            <div class="content-wrapper">
                <div class="quiz-container">
                    <h2>Teste tes connaissances sur les ${CHAPTER^} !</h2>
                    
                    <!-- Switch pour le mode difficile -->
                    <div class="quiz-mode-switch">
                        <label class="switch-container">
                            <input type="checkbox" id="hardMode" onchange="toggleHardMode()">
                            <span class="switch-slider"></span>
                            <span class="switch-label">Mode difficile (réponses à saisir)</span>
                        </label>
                    </div>
                    
                    <div class="question">
                        <h3>Question 1 : Première question ?</h3>
                        <div class="options">
                            <label onclick="checkAnswer(this, 'q1', false)">Réponse 1</label>
                            <label onclick="checkAnswer(this, 'q1', true)">Bonne réponse</label>
                            <label onclick="checkAnswer(this, 'q1', false)">Réponse 3</label>
                            <label onclick="checkAnswer(this, 'q1', false)">Réponse 4</label>
                        </div>
                        <div class="explanation" id="exp-q1">
                            ✨ Explication de la réponse 1
                        </div>
                    </div>

                    <!-- Répéter le bloc question pour les questions 2 à 5 -->
                    
                </div>
            </div>
        </div>

        <!-- Page Chronologie -->
        <div id="timeline" class="page">
            <div class="content-wrapper">
                <div class="timeline-container">
                    <h2>Les dates importantes</h2>
                    <p class="timeline-hint">👆 Clique sur chaque événement pour en savoir plus</p>
                    
                    <div class="timeline">
                        <div class="timeline-item" onclick="toggleTimelineItem(this)">
                            <div class="timeline-date">DATE</div>
                            <div class="timeline-content">
                                <h4>Événement 1</h4>
                                <p>Description de l'événement 1</p>
                            </div>
                        </div>
                        
                        <!-- Répéter le bloc timeline-item pour chaque événement -->
                        
                    </div>
                </div>
            </div>
        </div>
    </main>

    <!-- Charger le JavaScript -->
    <script src="scripts/main.js"></script>
</body>
</html>
EOL

# Créer les dossiers nécessaires s'ils n'existent pas
mkdir -p images
mkdir -p icons

# Vérifier si les icônes nécessaires existent
for icon in book brain calendar; do
    if [ ! -f "icons/${icon}.svg" ]; then
        echo "⚠️ Attention : L'icône icons/${icon}.svg est manquante"
    fi
done

# Créer un fichier README pour les images
cat > "images/README.md" << EOL
# Images pour le chapitre ${CHAPTER^}

## Images nécessaires :
1. \`${CHAPTER}-icon.png\` : Icône principale du chapitre (format carré recommandé)
2. Autres images du chapitre à placer ici...

## Format recommandé :
- PNG ou JPG
- Taille modérée (max 1MB par image)
- Dimensions raisonnables (max 1200px de large)
EOL

# Mettre à jour main.js avec les réponses du mode difficile
echo "
⚠️ N'oubliez pas d'ajouter les réponses du mode difficile dans scripts/main.js :

// Dans l'objet hardModeAnswers :
'${CHAPTER}': {
    'q1': ['réponse1', 'variante1', 'variante2'],
    'q2': ['réponse2'],
    'q3': ['réponse3'],
    'q4': ['réponse4'],
    'q5': ['réponse5']
}
"

# Afficher les instructions finales
echo "
✅ Chapitre créé avec succès !

À faire maintenant :
1. Ajouter l'icône ${CHAPTER}-icon.png dans le dossier images/
2. Compléter le contenu de la leçon dans chapitre-${CHAPTER}.html
3. Créer les questions du quiz avec leurs réponses
4. Ajouter les dates dans la chronologie
5. Ajouter les réponses du mode difficile dans scripts/main.js
6. Ajouter la carte du chapitre dans index.html avec :
   - Titre
   - Description
   - Période historique
   - Lien vers chapitre-${CHAPTER}.html

🎨 Classes CSS importantes à utiliser :
- date-important : Pour mettre en valeur les dates
- explanation : Pour les explications du quiz
- timeline-item : Pour les événements de la chronologie

📱 N'oubliez pas :
- Toutes les images doivent être optimisées
- Vérifier que le quiz fonctionne en mode normal et difficile
- Tester la navigation et le bouton de retour
- Vérifier que la chronologie est interactive
"

echo "🚀 Création terminée !" 