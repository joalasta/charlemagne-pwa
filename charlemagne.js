// Navigation entre les pages
function showPage(pageId) {
    const pages = document.querySelectorAll('.page');
    pages.forEach(page => page.classList.remove('active'));
    document.getElementById(pageId).classList.add('active');
    
    // Mettre à jour le titre dans la barre de navigation
    updatePageTitle(pageId);
    
    // Défiler vers le haut
    window.scrollTo(0, 0);
}

// Fonction pour mettre à jour le titre de la page
function updatePageTitle(pageId) {
    const titleElement = document.getElementById('page-title');
    
    if (pageId === 'home') {
        titleElement.textContent = ''; // Pas de titre sur la page d'accueil
    } else if (pageId === 'lesson') {
        titleElement.textContent = '📚 La Leçon';
    } else if (pageId === 'quiz') {
        titleElement.textContent = '🎯 Quiz';
    } else if (pageId === 'timeline') {
        titleElement.textContent = '📅 Chronologie';
    }
}

// Variables globales
let quizScore = 0;
let answeredQuestions = [];
let isHardMode = false;

// Questions et réponses pour le mode difficile
const hardModeAnswers = {
    'q1': ['732'],
    'q2': ['pépin le bref', 'pepin le bref'],
    'q3': ['aix-la-chapelle', 'aix la chapelle'],
    'q4': ['800'],
    'q5': ['missi dominici'],
    'q6': ['traité de verdun', 'traite de verdun', 'verdun'],
    'q7': ['pépin le bref', 'pepin le bref'],
    'q8': ['louis le pieux'],
    'q9': ['écoles', 'ecoles'],
    'q10': ['faire appliquer les lois, rendre la justice et organiser l\'armée', 'appliquer les lois', 'rendre la justice', 'organiser l\'armée'],
    'q11': ['987']
};

// Basculer entre mode normal et difficile
function toggleHardMode() {
    isHardMode = document.getElementById('hardMode').checked;
    resetQuiz();
    
    // Convertir toutes les questions
    const questions = document.querySelectorAll('.question');
    questions.forEach((question, index) => {
        const questionId = 'q' + (index + 1);
        const optionsDiv = question.querySelector('.options');
        
        if (isHardMode) {
            // Mode difficile : remplacer par un champ de saisie
            optionsDiv.innerHTML = `
                <div style="display: flex; align-items: center;">
                    <input type="text" class="hard-mode-input" id="input-${questionId}" placeholder="Tapez votre réponse...">
                    <button class="submit-answer" onclick="checkHardAnswer('${questionId}')">Valider</button>
                </div>
            `;
        } else {
            // Mode normal : remettre les options QCM
            restoreNormalMode(questionId, optionsDiv);
        }
    });
}

function restoreNormalMode(questionId, optionsDiv) {
    const qcmOptions = {
        'q1': [
            {text: '751', correct: false},
            {text: '732', correct: true},
            {text: '800', correct: false},
            {text: '843', correct: false}
        ],
        'q2': [
            {text: 'Charles Martel', correct: false},
            {text: 'Pépin le Bref', correct: true},
            {text: 'Louis le Pieux', correct: false},
            {text: 'Hugues Capet', correct: false}
        ],
        'q3': [
            {text: 'Paris', correct: false},
            {text: 'Rome', correct: false},
            {text: 'Aix-la-Chapelle', correct: true},
            {text: 'Poitiers', correct: false}
        ],
        'q4': [
            {text: '768', correct: false},
            {text: '800', correct: true},
            {text: '814', correct: false},
            {text: '843', correct: false}
        ],
        'q5': [
            {text: 'Les vassaux', correct: false},
            {text: 'Les missi dominici', correct: true},
            {text: 'Les évêques', correct: false},
            {text: 'Les moines', correct: false}
        ],
        'q6': [
            {text: 'Le traité de Paris', correct: false},
            {text: 'Le traité d\'Aix-la-Chapelle', correct: false},
            {text: 'Le traité de Verdun', correct: true},
            {text: 'Le traité de Rome', correct: false}
        ],
        'q7': [
            {text: 'Charlemagne', correct: false},
            {text: 'Charles Martel', correct: false},
            {text: 'Pépin le Bref', correct: true},
            {text: 'Louis le Pieux', correct: false}
        ],
        'q8': [
            {text: 'Charles le Chauve', correct: false},
            {text: 'Louis le Pieux', correct: true},
            {text: 'Lothaire', correct: false},
            {text: 'Hugues Capet', correct: false}
        ],
        'q9': [
            {text: 'Que seuls les nobles soient éduqués', correct: false},
            {text: 'Que des écoles soient ouvertes dans chaque évêché et monastère', correct: true},
            {text: 'Que l\'éducation soit interdite', correct: false},
            {text: 'Que seuls les garçons soient éduqués', correct: false}
        ],
        'q10': [
            {text: 'Enseigner dans les écoles', correct: false},
            {text: 'Faire appliquer les lois, rendre la justice et organiser l\'armée', correct: true},
            {text: 'Construire des églises', correct: false},
            {text: 'Collecter les impôts seulement', correct: false}
        ],
        'q11': [
            {text: '843', correct: false},
            {text: '887', correct: false},
            {text: '987', correct: true},
            {text: '1000', correct: false}
        ]
    };
    
    const options = qcmOptions[questionId];
    optionsDiv.innerHTML = options.map(option => 
        `<label onclick="checkAnswer(this, '${questionId}', ${option.correct})">${option.text}</label>`
    ).join('');
}

// Vérifier la réponse en mode difficile
function checkHardAnswer(questionId) {
    if (answeredQuestions.includes(questionId)) {
        return;
    }
    
    const input = document.getElementById('input-' + questionId);
    const userAnswer = input.value.toLowerCase().trim();
    const correctAnswers = hardModeAnswers[questionId];
    
    answeredQuestions.push(questionId);
    
    // Désactiver le champ et le bouton
    input.disabled = true;
    const button = input.parentElement.querySelector('.submit-answer');
    button.disabled = true;
    
    // Vérifier si la réponse est correcte
    const isCorrect = correctAnswers.some(answer => 
        userAnswer.includes(answer.toLowerCase()) || 
        answer.toLowerCase().includes(userAnswer)
    );
    
    if (isCorrect) {
        input.classList.add('correct');
        quizScore++;
    } else {
        input.classList.add('incorrect');
        // Afficher la bonne réponse
        input.placeholder = `Réponse: ${correctAnswers[0]}`;
    }
    
    updateQuizScore();
    
    // Afficher l'explication
    const explanation = document.getElementById('exp-' + questionId);
    explanation.classList.add('show');
}

// Quiz avec feedback immédiat
function checkAnswer(label, questionId, isCorrect) {
    // Vérifier si la question a déjà été répondue
    if (answeredQuestions.includes(questionId)) {
        return;
    }
    
    answeredQuestions.push(questionId);
    
    // Désactiver tous les labels de cette question
    const question = label.parentElement;
    const labels = question.querySelectorAll('label');
    labels.forEach(l => {
        l.style.pointerEvents = 'none';
        l.style.cursor = 'default';
    });
    
    // Marquer la réponse
    if (isCorrect) {
        label.classList.add('correct');
        quizScore++;
        updateQuizScore();
    } else {
        label.classList.add('incorrect');
        // Montrer la bonne réponse
        labels.forEach((l, index) => {
            const correctAnswers = {
                'q1': 1,  // 732
                'q2': 1,  // Pépin le Bref
                'q3': 2,  // Aix-la-Chapelle
                'q4': 1,  // 800
                'q5': 1,  // missi dominici
                'q6': 2,  // Verdun
                'q7': 2,  // Pépin le Bref
                'q8': 1,  // Louis le Pieux
                'q9': 1,  // écoles
                'q10': 1, // comtes
                'q11': 2  // 987
            };
            
            if (index === correctAnswers[questionId]) {
                l.classList.add('correct');
            }
        });
    }
    
    // Afficher l'explication
    const explanation = document.getElementById('exp-' + questionId);
    explanation.classList.add('show');
}

function updateQuizScore() {
    document.getElementById('liveScore').textContent = `Score: ${quizScore}/11`;
}

function resetQuiz() {
    quizScore = 0;
    answeredQuestions = [];
    updateQuizScore();
    
    // Réinitialiser toutes les questions
    const labels = document.querySelectorAll('.options label');
    labels.forEach(label => {
        label.classList.remove('correct', 'incorrect');
        label.style.pointerEvents = 'auto';
        label.style.cursor = 'pointer';
    });
    
    // Cacher les explications
    document.querySelectorAll('.explanation').forEach(exp => {
        exp.classList.remove('show');
    });
}

// Chronologie interactive
function toggleTimelineItem(item) {
    // Fermer tous les autres items
    document.querySelectorAll('.timeline-item').forEach(i => {
        if (i !== item) {
            i.classList.remove('active');
        }
    });
    
    // Basculer l'item cliqué
    item.classList.toggle('active');
}

// Gestion de la navigation retour
function handleBackNavigation() {
    window.location.href = 'index.html';
}

// Initialisation au chargement
document.addEventListener('DOMContentLoaded', function() {
    // Ajouter les écouteurs d'événements pour les boutons retour
    document.querySelectorAll('.back-btn').forEach(btn => {
        btn.addEventListener('click', function(e) {
            e.preventDefault();
            handleBackNavigation();
        });
    });
    
    updatePageTitle('home');
    updateQuizScore();
});