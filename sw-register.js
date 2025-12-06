// Enregistrement du Service Worker et détection des mises à jour
if ('serviceWorker' in navigator) {
    let refreshing = false;
    
    navigator.serviceWorker.register('/sw.js')
        .then(function(registration) {
            console.log('Service Worker enregistré avec succès');
            
            // Vérifier les mises à jour toutes les heures
            setInterval(function() {
                registration.update();
            }, 3600000); // 1 heure
            
            // Détecter quand un nouveau service worker est disponible
            registration.addEventListener('updatefound', function() {
                const newWorker = registration.installing;
                
                newWorker.addEventListener('statechange', function() {
                    if (newWorker.state === 'installed' && navigator.serviceWorker.controller) {
                        // Un nouveau service worker est disponible
                        // Le service worker utilise skipWaiting(), donc il s'active automatiquement
                        // On recharge la page pour utiliser la nouvelle version
                        if (!refreshing) {
                            refreshing = true;
                            window.location.reload();
                        }
                    }
                });
            });
        })
        .catch(function(error) {
            console.log('Erreur lors de l\'enregistrement du Service Worker:', error);
        });
    
    // Écouter les messages du service worker
    navigator.serviceWorker.addEventListener('controllerchange', function() {
        // Quand le contrôle change, recharger la page
        if (!refreshing) {
            refreshing = true;
            window.location.reload();
        }
    });
}

