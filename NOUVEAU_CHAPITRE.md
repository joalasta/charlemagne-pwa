## 🎯 Instructions pour Claude

Claude, voici tes instructions pour créer un nouveau chapitre d'histoire à partir des photos d'un cahier d'élève. Tu dois d'abord lire toute ces instructions afin d'être sur de bien comprendre la globalité du projet avant de démarrer la création des contenus.

### 1. Analyse initiale
À partir des photos fournies, tu dois :
- Identifier le titre exact du chapitre et son numéro (H...)
- Déterminer la période historique concernée
- Proposer un sous-titre accrocheur qui résume le chapitre
- Vérifier la position chronologique par rapport aux chapitres existants
- Organiser la leçon en conformité avec la structure de `lesson-template.html`:

### 2. Structuration du contenu de la leçon
- Sections logiques avec titres en te basant sur les photos
- Mettre en évidence TOUTES les dates avec `<span class="date-important">DATE</span>`
- Mettre en surbrillance les mots-clés avec `<span class="highlight">MOT</span>`
- Respecter les formats de date :
  * Avant J.C. : `-52 av. J.-C.`
  * Siècles : `IVe siècle`
  * Années simples : `481`

### 3. Création du quiz
Tu dois créer 10 questions comprenant chacune :
- Une question basée uniquement sur le contenu de la leçon
- 4 réponses possibles dont une seule correcte
- Une explication détaillée de la bonne réponse
- Utiliser la classe `question` pour la structure
- Utiliser la classe `explanation` pour les explications
- Mettre à jour le compteur de score en haut de page pour afficher "Score: 0/10"

### 4. Création de la chronologie
Tu dois inclure :
- TOUTES les dates mentionnées dans la leçon
- Pour chaque date :
  * L'événement principal
  * Une description courte mais détaillée
- Utiliser la classe `timeline-item` pour chaque événement
- Les dates doivent être dans l'ordre chronologique
- Inclure aussi les périodes (siècles, règnes, etc.)

### 5. Création des fichiers
Tu dois :
1. Créer `chapitre-[nom].html` en utilisant le template existant
2. Mettre à jour `index.html` en ajoutant la carte du chapitre au bon endroit chronologique
3. Ne pas modifier :
   - Le CSS existant
   - La structure du template
   - Les scripts JavaScript
   - Les autres chapitres

### 6. Prompt pour l'image
Tu dois me retourner dans le chat ce prompt exact :
```
Portrait historique de [SUJET], style cartoon minimaliste, 230x230px, fond transparent. Vue de face, cadrage serré sur le visage et les épaules.
```

### 7. Vérification finale
Tu dois vérifier :
- La conformité avec la structure de `lesson-template.html`
- La cohérence des balises HTML
- L'utilisation correcte des classes CSS pour l'index et la page chapitre
- La chronologie des événements
- Le quiz (10 questions)
- La mise à jour de l'index
- La bonne chronologie des cartes de l'index.html 

## 📁 Structure des fichiers à respecter
```
.
├── lesson-template.html  # RÉFÉRENCE À SUIVRE EXACTEMENT
├── chapitre-[nom].html  # Nouveau chapitre basé sur le template
├── images/
│   └── [nom]-icon.png   # Icône du chapitre (à créer plus tard)
└── index.html           # À mettre à jour
```

## 🎨 Classes CSS à utiliser
- `date-important` : Dates importantes
- `highlight` : Mots-clés
- `timeline-item` : Événements chronologiques
- `question` : Questions du quiz
- `explanation` : Explications des réponses

## ⚠️ Important
- Tout le contenu doit provenir uniquement des photos du cahier
- Respecter la chronologie historique dans l'index
- Ne pas modifier les fichiers existants sauf index.html
- TOUJOURS se référer à `lesson-template.html` pour la structure
- Inclure TOUTES les dates dans la chronologie
- Créer EXACTEMENT 10 questions de quiz 

## 📅 Règles de formatage des dates

### Dates et périodes
- Utiliser les chiffres arabes (pas de chiffres romains)
- Format pour les dates avant J.-C. : `-52 av. J.-C.`
- Format pour les siècles : `1er siècle`, `5e siècle` (pas de chiffres romains)
- Format pour les périodes : `1 à 500` (pas "Ier-Ve siècles")
- Format pour les années simples : `481`

### Ordre chronologique
1. Convertir toutes les dates en années numériques pour le classement
2. Placer les chapitres dans l'ordre chronologique strict
3. En cas de périodes qui se chevauchent, utiliser la date de début pour le classement

Exemple d'ordre :
```
-1200 à -50   : Les Celtes et les Gaulois
-58 à -46     : Les Romains et la guerre des Gaules
481 à 751     : Clovis et les Mérovingiens
751 à 987     : Charlemagne et les Carolingiens
```

## 🏗️ Structure obligatoire du chapitre

### 1. Pages requises
Chaque chapitre DOIT avoir 3 pages distinctes :
```html
<!-- 1. Page d'accueil -->
<div id="home" class="page active">
    - Image du personnage historique
    - Titre et sous-titre
    - 3 cartes de navigation
</div>

<!-- 2. Page Leçon -->
<div id="lesson" class="page">
    - 4 sections numérotées
    - Section "À retenir" à la fin
    - Dates en chiffres arabes
</div>

<!-- 3. Page Quiz -->
<div id="quiz" class="page">
    - Switch mode difficile
    - 10 questions
    - Score en direct
</div>

<!-- 4. Page Chronologie -->
<div id="timeline" class="page">
    - Événements cliquables
    - Dates en ordre chronologique
</div>
```

### 2. Fichiers requis
Vérifier la présence de :
```
📁 icons/
  ├── book.svg
  ├── brain.svg
  └── calendar.svg
📁 images/
  └── [nom]-icon.png
📄 navigation.css
📄 charlemagne.js
```

### 3. Meta tags obligatoires
```html
<head>
    <!-- PWA Meta tags -->
    <meta name="theme-color" content="#2463EB">
    <meta name="description" content="...">
    <link rel="manifest" href="manifest.json">
    <link rel="stylesheet" href="navigation.css">
    <link rel="stylesheet" href="style.css">
</head>
```

### 4. Navigation
```html
<nav class="main-nav">
    <a href="index.html" class="nav-back">← Accueil</a>
    <div class="nav-center">
        <h2 class="nav-title"></h2>
        <div class="score-live">Score: 0/10</div>
    </div>
    <button class="reset-quiz">🔄</button>
</nav>
```

⚠️ TOUJOURS copier la structure depuis `lesson-template.html` et remplacer uniquement le contenu, jamais la structure. 