# Histoires Interactives - PWA

Une application web progressive (PWA) éducative pour apprendre l'histoire de manière interactive.

## 📱 Fonctionnalités

- Application installable sur mobile et desktop
- Navigation fluide et interface responsive
- Quiz interactifs
- Leçons d'histoire illustrées
- Chronologie interactive

## 🎯 Chapitre actuel

- Charlemagne et les Carolingiens
  - Histoire de l'empire carolingien
  - Quiz sur Charlemagne
  - Chronologie des événements importants

## 🛠️ Technologies utilisées

- HTML5
- CSS3
- JavaScript
- PWA (Progressive Web App)

## 📥 Installation

1. Clonez le dépôt
```bash
git clone [url-du-repo]
```

2. Ouvrez `index.html` dans votre navigateur

3. Pour le développement, utilisez un serveur local comme Live Server

## 🚀 Déploiement

L'application est conçue pour être déployée sur n'importe quel serveur web statique.

## 📝 Licence

© 2024 - Tous droits réservés

## 📚 Ajouter une nouvelle leçon

Pour ajouter une nouvelle leçon à partir des photos d'un cahier, utilisez ce prompt avec Claude dans Cursor :

```
Je souhaite créer une nouvelle leçon d'histoire à partir des photos du cahier de mon fils. Voici ce dont j'ai besoin :

ÉTAPE 1 : CRÉATION DU FICHIER
- À partir des photos, identifier le nom du chapitre/personnage
- Créer un nouveau fichier chapitre-[nom].html basé sur lesson-template.html
  (exemple : chapitre-clovis.html pour une leçon sur Clovis)

ÉTAPE 2 : CONTENU DE LA LEÇON
1. Informations générales (pour les balises meta et titres) :
   - Titre complet du chapitre
   - Un sous-titre accrocheur qui résume le chapitre
   - Le numéro du chapitre (H...)

2. Pour la leçon principale, je vais partager :
   - Des photos du cours écrit dans le cahier
   - Des photos des schémas/illustrations si présents
   → Structurer le contenu en 4 sections logiques
   → Identifier les dates importantes à mettre en <span class="date-important">
   → Identifier les mots clés à mettre en <span class="highlight">

3. Pour la chronologie :
   - Extraire les dates et événements importants du cours
   - Pour chaque date, fournir une courte description détaillée

4. Pour le quiz :
   - Créer environ 10-12 questions basées uniquement sur le contenu du cours
   - Pour chaque question :
     * Une question claire
     * 4 réponses possibles dont une seule correcte
     * Une explication détaillée de la réponse

5. Images nécessaires :
   - Une image représentative du sujet pour la page d'accueil
   - Les icônes sont déjà en place (book.svg, brain.svg, calendar.svg)

ÉTAPE 3 : MISE À JOUR DE L'INDEX
- Ajouter la nouvelle leçon dans index.html
- Important : Respecter l'ordre chronologique historique des leçons
  (exemple : si la nouvelle leçon concerne une période avant Charlemagne, 
   la placer avant la carte de Charlemagne dans la grille)
- Vérifier que les liens et la navigation fonctionnent correctement

Je vais maintenant partager les photos du cahier, et j'aimerais que tu m'aides à transformer ce contenu en une nouvelle page web en suivant ces étapes précises.
```

## 🔄 Processus

1. Ouvrir Cursor
2. Copier le prompt ci-dessus
3. Partager les photos du cahier
4. Claude créera automatiquement :
   - Le nouveau fichier de la leçon
   - Le contenu structuré
   - Les questions du quiz
   - La chronologie
   - La mise à jour de l'index.html

## 🖼️ Images requises

Après la création de la leçon, il faudra ajouter :
- `images/[nom].png` : Image principale de la leçon
- `images/[nom]-icon.png` : Icône pour la page d'accueil

## 📝 Structure des fichiers

```
.
├── chapitre-[nom].html    # Nouvelle leçon
├── images/
│   ├── [nom].png         # Image principale
│   └── [nom]-icon.png    # Icône
├── index.html            # Page d'accueil mise à jour
└── lesson-template.html  # Template de base
``` 