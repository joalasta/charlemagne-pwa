#!/bin/zsh

echo "🎓 Assistant de création de leçon d'histoire"
echo "==========================================\n"

echo "📚 Je vais vous aider à créer une nouvelle leçon."
echo "Le processus est le suivant :\n"
echo "1. Vous allez partager les photos du cahier"
echo "2. Je vais analyser le contenu et identifier le thème"
echo "3. Après votre confirmation, je créerai la page du chapitre"
echo "4. Je vous donnerai ensuite le prompt pour l'image\n"

echo -n "Avez-vous les photos du cahier à partager ? (o/n) : "
read response

if [[ $response =~ ^[Oo]$ ]]; then
    echo "\n📸 Super ! Voici comment nous allons procéder :"
    echo "1. Partagez vos photos du cahier"
    echo "2. Je vais analyser le contenu et vous confirmer le thème identifié"
    echo "3. Après votre accord, je créerai la page avec le contenu structuré"
    echo "4. Une fois la page créée, je vous donnerai le prompt pour l'image"
    echo "\nVous pouvez maintenant partager vos photos ! 📚"
else
    echo "\n👋 D'accord, revenez quand vous aurez les photos du cahier."
fi 