// Variables globales
let currentScore = 0;
let totalQuestions = 5; // Cette valeur sera mise à jour dynamiquement
let hardMode = false;
let answeredQuestions = [];

// Questions et réponses pour le mode difficile
const hardModeAnswers = {
    // Gaulois
    'gaulois': {
        'q1': ['-1200', '1200 av JC', '1200 avant JC'],
        'q2': ['-800', '-700', '800 av JC', '700 av JC'],
        'q3': ['60', 'soixante'],
        'q4': ['druides', 'les druides'],
        'q5': ['moulin à eau', 'moulin'],
        'q6': ['paysans', 'artisans', 'paysans et artisans'],
        'q7': ['blé', 'vigne', 'céréales'],
        'q8': ['fer', 'le fer'],
        'q9': ['lutèce', 'lutece']
    },
    // Gallo-romains
    'gallo-romains': {
        'q1': ['500', '500 ans', 'cinq cents ans'],
        'q2': ['toge', 'la toge'],
        'q3': ['villas', 'les villas', 'villa'],
        'q4': ['constantin', 'constantin 1er'],
        'q5': ['313', '313 après JC']
    }
};

// Initialisation
document.addEventListener('DOMContentLoaded', function() {
    // Mettre à jour le nombre total de questions
    const questions = document.querySelectorAll('.question');
    if (questions.length > 0) {
        totalQuestions = questions.length;
        updateScore();
    }

    // Vérifier si on est sur la page quiz
    if (document.getElementById('quiz')) {
        document.body.classList.add('quiz-page');
    }
});

// Afficher une page spécifique
function showPage(pageId) {
    // Cacher toutes les pages
    document.querySelectorAll('.page').forEach(page => {
        page.classList.remove('active');
    });
    
    // Afficher la page demandée
    document.getElementById(pageId).classList.add('active');
    
    // Mettre à jour le titre dans la navigation
    updateNavTitle(pageId);
    
    // Mettre à jour le bouton de retour
    const navBack = document.querySelector('.nav-back');
    if (pageId === 'home') {
        navBack.textContent = '← Accueil';
        navBack.href = 'index.html';
        navBack.onclick = null;
    } else {
        navBack.textContent = '← Retour';
        navBack.href = '#';
        navBack.onclick = (e) => {
            e.preventDefault();
            showPage('home');
        };
    }

    // Gérer l'affichage du score et du bouton reset
    const scoreElement = document.querySelector('.score-live');
    const resetButton = document.querySelector('.nav-reset');
    
    if (pageId === 'quiz') {
        document.body.classList.add('quiz-page');
        if (scoreElement) scoreElement.style.display = 'block';
        if (resetButton) resetButton.style.display = 'block';
    } else {
        document.body.classList.remove('quiz-page');
        if (scoreElement) scoreElement.style.display = 'none';
        if (resetButton) resetButton.style.display = 'none';
    }
}

// Mettre à jour le titre dans la navigation
function updateNavTitle(pageId) {
    const title = document.querySelector('.nav-title');
    if (!title) return;
    
    // Mettre à jour le titre selon la section
    switch(pageId) {
        case 'lesson':
            title.textContent = '📚 La Leçon';
            break;
        case 'quiz':
            title.textContent = '🎯 Quiz';
            break;
        case 'timeline':
            title.textContent = '📅 Chronologie';
            break;
        default:
            title.textContent = '';
    }
}

// Vérifier une réponse au quiz
function checkAnswer(label, questionId, isCorrect) {
    if (hardMode || !label || label.classList.contains('answered')) return;
    
    // Supprimer les classes précédentes
    const labels = label.parentElement.querySelectorAll('label');
    labels.forEach(l => {
        l.classList.remove('correct', 'incorrect');
        l.classList.add('answered');
    });
    
    // Ajouter la classe appropriée
    if (isCorrect) {
        label.classList.add('correct');
        if (!answeredQuestions.includes(questionId)) {
            currentScore++;
            answeredQuestions.push(questionId);
            updateScore();
        }
    } else {
        label.classList.add('incorrect');
        // Trouver et marquer la bonne réponse
        labels.forEach(l => {
            if (l.getAttribute('onclick').includes('true')) {
                l.classList.add('correct');
            }
        });
    }
    
    // Afficher l'explication
    const explanation = document.getElementById('exp-' + questionId);
    if (explanation) {
        explanation.classList.add('show');
    }
}

// Mettre à jour le score
function updateScore() {
    const scoreElement = document.getElementById('liveScore');
    if (scoreElement) {
        scoreElement.textContent = `Score: ${currentScore}/${totalQuestions}`;
    }
}

// Réinitialiser le quiz
function resetQuiz() {
    currentScore = 0;
    answeredQuestions = [];
    updateScore();
    
    if (hardMode) {
        // Réinitialiser les champs de saisie en mode difficile
        document.querySelectorAll('.hard-mode-input').forEach(input => {
            input.value = '';
            input.disabled = false;
            input.classList.remove('correct', 'incorrect');
            input.placeholder = 'Tapez votre réponse...';
        });
        
        // Réactiver les boutons de validation
        document.querySelectorAll('.submit-answer').forEach(button => {
            button.disabled = false;
        });
    } else {
        // Réinitialiser les labels en mode normal
        document.querySelectorAll('.question label').forEach(label => {
            label.classList.remove('correct', 'incorrect', 'answered');
        });
    }
    
    // Cacher toutes les explications
    document.querySelectorAll('.explanation').forEach(exp => {
        exp.classList.remove('show');
    });
}

// Basculer le mode difficile
function toggleHardMode() {
    hardMode = document.getElementById('hardMode').checked;
    
    // Sauvegarder les labels originaux si on passe en mode difficile
    if (hardMode) {
        document.querySelectorAll('.options').forEach(optionsDiv => {
            if (!optionsDiv.getAttribute('data-labels')) {
                optionsDiv.setAttribute('data-labels', optionsDiv.innerHTML);
            }
        });
    }
    
    // Réinitialiser le quiz
    resetQuiz();
    
    // Convertir toutes les questions
    const questions = document.querySelectorAll('.question');
    questions.forEach((question, index) => {
        const questionId = 'q' + (index + 1);
        const optionsDiv = question.querySelector('.options');
        
        if (hardMode) {
            // Mode difficile : remplacer par un champ de saisie
            optionsDiv.innerHTML = `
                <div style="display: flex; align-items: center;">
                    <input type="text" class="hard-mode-input" id="input-${questionId}" placeholder="Tapez votre réponse...">
                    <button class="submit-answer" onclick="checkHardAnswer('${questionId}')">Valider</button>
                </div>
            `;
        } else {
            // Mode normal : restaurer les options QCM
            const labels = optionsDiv.getAttribute('data-labels');
            if (labels) {
                optionsDiv.innerHTML = labels;
            }
        }
    });
}

// Vérifier la réponse en mode difficile
function checkHardAnswer(questionId) {
    if (answeredQuestions.includes(questionId)) return;
    
    const input = document.getElementById('input-' + questionId);
    if (!input) return;
    
    const userAnswer = input.value.toLowerCase().trim();
    if (!userAnswer) return;
    
    // Déterminer le chapitre actuel
    const pathname = window.location.pathname;
    const chapter = pathname.includes('gaulois') ? 'gaulois' : 
                   pathname.includes('gallo-romains') ? 'gallo-romains' : null;
    
    if (!chapter || !hardModeAnswers[chapter] || !hardModeAnswers[chapter][questionId]) return;
    
    const correctAnswers = hardModeAnswers[chapter][questionId];
    
    // Désactiver le champ et le bouton
    input.disabled = true;
    const button = input.parentElement.querySelector('.submit-answer');
    if (button) button.disabled = true;
    
    // Vérifier si la réponse est correcte
    const isCorrect = correctAnswers.some(answer => 
        userAnswer.includes(answer.toLowerCase()) || 
        answer.toLowerCase().includes(userAnswer)
    );
    
    if (isCorrect) {
        input.classList.add('correct');
        if (!answeredQuestions.includes(questionId)) {
            currentScore++;
            answeredQuestions.push(questionId);
            updateScore();
        }
    } else {
        input.classList.add('incorrect');
        input.placeholder = `Réponse: ${correctAnswers[0]}`;
    }
    
    // Afficher l'explication
    const explanation = document.getElementById('exp-' + questionId);
    if (explanation) {
        explanation.classList.add('show');
    }
}

// Basculer l'affichage des détails dans la chronologie
function toggleTimelineItem(item) {
    if (item) {
        item.classList.toggle('active');
    }
} 