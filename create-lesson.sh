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

# Nom du chapitre (en minuscules, sans espaces)
CHAPTER=$1
# Convertir la première lettre en majuscule
CHAPTER_TITLE="$(tr '[:lower:]' '[:upper:]' <<< ${CHAPTER:0:1})${CHAPTER:1}"

# Copier le template et créer le fichier HTML
if [ ! -f "lesson-template.html" ]; then
    echo "❌ ERREUR : Le fichier lesson-template.html est manquant"
    exit 1
fi

cp lesson-template.html "chapitre-${CHAPTER}.html"

# Remplacer les placeholders de base
sed -i '' "s/\[TITRE_ROI\]/Les ${CHAPTER_TITLE}/g" "chapitre-${CHAPTER}.html"
sed -i '' "s/\[TITRE_COURT\]/${CHAPTER_TITLE}/g" "chapitre-${CHAPTER}.html"
sed -i '' "s/\[IMAGE_ROI\]/${CHAPTER}-icon/g" "chapitre-${CHAPTER}.html"
sed -i '' "s/\[NOMBRE_QUESTIONS\]/5/g" "chapitre-${CHAPTER}.html"
sed -i '' "s/charlemagne\.js/scripts\/main.js/g" "chapitre-${CHAPTER}.html"

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
   - [DATE_1], [DATE_2], etc. : Dates importantes
   - [EVENEMENT_1], [EVENEMENT_2], etc. : Événements correspondants

2. Pour la chronologie :
   - Remplacer [DATE], [TITRE_EVENEMENT], [DESCRIPTION_EVENEMENT]
   - Copier le bloc timeline-item pour chaque événement
   - Les organiser dans l'ordre chronologique

3. Pour le quiz :
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
   - calendar.svg

ÉTAPE 3 : INTÉGRATION
--------------------
1. Ajouter la carte du chapitre dans index.html
2. Respecter l'ordre chronologique historique
3. Vérifier tous les liens et la navigation
4. Tester le quiz en mode normal et difficile

🎨 Classes CSS disponibles :
- date-important : Pour les dates importantes
- highlight : Pour les mots clés
- explanation : Pour les explications du quiz
- timeline-item : Pour la chronologie
- charlemagne-image : Pour l'image principale (ne pas utiliser icon-img)
- subtitle : Pour le sous-titre (ne pas utiliser period)

📝 Fichiers à éditer :
1. chapitre-${CHAPTER}.html (remplacer les placeholders)
2. scripts/main.js (réponses du mode difficile)
3. index.html (ajout de la carte)
"

echo "🚀 Création de la structure terminée ! Vous pouvez maintenant commencer à personnaliser le contenu." 


