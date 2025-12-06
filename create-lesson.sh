#!/bin/bash

# Vérifier si un argument a été fourni
if [ $# -eq 0 ]; then
    echo "❌ ERREUR : Aucun nom de chapitre fourni"
    echo "Usage: ./create-lesson.sh <nom-du-chapitre>"
    echo "Exemple: ./create-lesson.sh vikings"
    exit 1
fi

# Avertissement important sur les photos
echo "⚠️ ATTENTION : Avant de créer la leçon"
echo "============================================"
echo "Selon le README.md, vous devez d'abord :"
echo "1. Avoir les photos du cahier de votre fils"
echo "2. Identifier le contenu exact du cours"
echo "3. Repérer les schémas et illustrations"
echo ""
echo "Avez-vous les photos du cahier ? (o/n)"
read -p "> " has_photos

if [ "$has_photos" != "o" ]; then
    echo "❌ Veuillez d'abord prendre en photo le cahier."
    echo "   Cela permettra de créer une leçon fidèle au cours."
    exit 1
fi

# Demander la catégorie
echo ""
echo "📚 Dans quelle catégorie créer cette leçon ?"
echo "1) Histoire (avec chronologie)"
echo "2) Sciences (sans chronologie)"
read -p "Choisissez (1 ou 2) : " category_choice

if [ "$category_choice" = "2" ]; then
    CATEGORY="sciences"
    TEMPLATE="lesson-template-sciences.html"
    BACK_LINK="sciences.html"
else
    CATEGORY="histoire"
    TEMPLATE="lesson-template.html"
    BACK_LINK="histoire.html"
fi

# Nom du chapitre (en minuscules, sans espaces)
CHAPTER=$1
# Convertir la première lettre en majuscule
CHAPTER_TITLE="$(tr '[:lower:]' '[:upper:]' <<< ${CHAPTER:0:1})${CHAPTER:1}"

# Copier le template et créer le fichier HTML
if [ ! -f "$TEMPLATE" ]; then
    echo "❌ ERREUR : Le fichier $TEMPLATE est manquant"
    exit 1
fi

cp "$TEMPLATE" "chapitre-${CHAPTER}.html"

# Remplacer les placeholders de base
sed -i '' "s/\[TITRE_ROI\]/Les ${CHAPTER_TITLE}/g" "chapitre-${CHAPTER}.html"
sed -i '' "s/\[TITRE_COURT\]/${CHAPTER_TITLE}/g" "chapitre-${CHAPTER}.html"
sed -i '' "s/\[IMAGE_ROI\]/${CHAPTER}-icon/g" "chapitre-${CHAPTER}.html"
sed -i '' "s/\[NOMBRE_QUESTIONS\]/5/g" "chapitre-${CHAPTER}.html"
sed -i '' "s/charlemagne\.js/scripts\/main.js/g" "chapitre-${CHAPTER}.html"

# Pour les sciences, mettre à jour le lien de retour
if [ "$CATEGORY" = "sciences" ]; then
    sed -i '' "s/sciences\.html/${BACK_LINK}/g" "chapitre-${CHAPTER}.html"
fi

# Créer les dossiers nécessaires s'ils n'existent pas
mkdir -p images
mkdir -p icons

# Vérifier si les icônes nécessaires existent
if [ "$CATEGORY" = "sciences" ]; then
    # Sciences : seulement book et brain (pas de calendar)
    for icon in book brain; do
        if [ ! -f "icons/${icon}.svg" ]; then
            echo "⚠️ Attention : L'icône icons/${icon}.svg est manquante"
        fi
    done
else
    # Histoire : book, brain et calendar
    for icon in book brain calendar; do
        if [ ! -f "icons/${icon}.svg" ]; then
            echo "⚠️ Attention : L'icône icons/${icon}.svg est manquante"
        fi
    done
fi

# Créer un fichier README pour les images
cat > "images/README.md" << EOL
# Images pour le chapitre ${CHAPTER_TITLE}

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
✅ Structure du chapitre créée avec succès !

ÉTAPE 1 : CONTENU DE LA LEÇON
-----------------------------
1. Dans chapitre-${CHAPTER}.html, remplacez les placeholders suivants :
   - [NUMERO_CHAPITRE] : Numéro du chapitre (ex: H7)
   - [TITRE_LECON] : Titre complet de la leçon
   - [SOUS_TITRE] : Sous-titre ou période historique
   - [TITRE_SECTION_1] à [TITRE_SECTION_4] : Titres des sections
   - [CONTENU_SECTION_1] à [CONTENU_SECTION_4] : Contenu des sections
$(if [ "$CATEGORY" = "histoire" ]; then echo "   - [DATE_1], [DATE_2], etc. : Dates importantes"; echo "   - [EVENEMENT_1], [EVENEMENT_2], etc. : Événements correspondants"; echo ""; echo "2. Pour la chronologie :"; echo "   - Remplacer [DATE], [TITRE_EVENEMENT], [DESCRIPTION_EVENEMENT]"; echo "   - Copier le bloc timeline-item pour chaque événement"; echo "   - Les organiser dans l'ordre chronologique"; echo ""; echo "3. Pour le quiz :"; else echo "   - [POINT_1], [POINT_2], etc. : Points clés à retenir"; echo ""; echo "2. Pour le quiz :"; fi)
   - Remplacer [N], [QUESTION], [REPONSE_1], etc.
   - Copier le bloc question pour chaque question
   - Ajouter [EXPLICATION] pour chaque réponse

ÉTAPE 2 : RESSOURCES NÉCESSAIRES
-------------------------------
1. Ajouter l'icône ${CHAPTER}-icon.png dans le dossier images/
2. Optimiser toutes les images du cours pour le web
3. Vérifier que les icônes sont présentes :
   - book.svg
   - brain.svg
$(if [ "$CATEGORY" = "histoire" ]; then echo "   - calendar.svg"; fi)

ÉTAPE 3 : INTÉGRATION
--------------------
1. Ajouter la carte du chapitre dans ${BACK_LINK}
2. Respecter l'ordre chronologique (pour l'histoire uniquement)
3. Vérifier tous les liens et la navigation
4. Tester le quiz en mode normal et difficile

🎨 Classes CSS disponibles :
- highlight : Pour les mots clés
- explanation : Pour les explications du quiz
$(if [ "$CATEGORY" = "histoire" ]; then echo "- date-important : Pour les dates importantes"; echo "- timeline-item : Pour la chronologie"; fi)
- charlemagne-image : Pour l'image principale (ne pas utiliser icon-img)
- subtitle : Pour le sous-titre (ne pas utiliser period)

📝 Fichiers à éditer :
1. chapitre-${CHAPTER}.html (remplacer les placeholders)
2. scripts/main.js (réponses du mode difficile)
3. index.html (ajout de la carte)
"

echo "🚀 Création de la structure terminée ! Vous pouvez maintenant commencer à personnaliser le contenu." 


