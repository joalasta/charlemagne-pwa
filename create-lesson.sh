#!/bin/zsh

echo "🎓 Assistant de création de leçon d'histoire"
echo "==========================================\n"

echo "📚 Je vais vous aider à créer une nouvelle leçon."
echo "Le processus est le suivant :\n"
echo "1. Je vais ouvrir le README avec les instructions"
echo "2. Vous pourrez copier le prompt pour Claude"
echo "3. Vous pourrez ensuite importer vos photos"
echo "4. Une fois la leçon créée, je vous donnerai le prompt pour l'image\n"

# Attendre 2 secondes pour que l'utilisateur puisse lire
sleep 2

# Ouvrir le README (en utilisant l'application par défaut)
if [[ "$OSTYPE" == "darwin"* ]]; then
    open README.md
else
    xdg-open README.md
fi

echo "\n✨ Le README est maintenant ouvert."
echo "Veuillez copier le prompt qui se trouve dans la section '📚 Ajouter une nouvelle leçon'\n"

echo -n "Êtes-vous prêt à importer vos photos ? (o/n) : "
read response

if [[ $response =~ ^[Oo]$ ]]; then
    echo "\n📸 Super ! Vous pouvez maintenant partager vos photos avec Claude dans Cursor."
    echo "Une fois que Claude aura créé la leçon et déterminé son nom, voici le prompt à utiliser pour générer l'image :\n"
    
    echo "🎨 Prompt pour la génération de l'image :"
    echo "\nPortrait ([nom-lecon]-icon.png) :"
    echo "\"Portrait historique d'un [personnage], style cartoon minimaliste, 230x230px, fond transparent. Vue de face, cadrage serré sur le visage et les épaules.\""
    
    echo "\nRemplacez [nom-lecon] et [personnage] par les termes appropriés que Claude aura déterminés."
    echo "Bonne création de leçon ! 🚀"
else
    echo "\n👋 Pas de problème ! Revenez quand vous serez prêt."
fi 