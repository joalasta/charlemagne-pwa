const CACHE_NAME = 'charlemagne-app-v3';
const urlsToCache = [
  './',
  './index.html',
  './manifest.json',
  './icons/icon.svg'
];

self.addEventListener('install', function(event) {
  event.waitUntil(
    caches.open(CACHE_NAME)
      .then(function(cache) {
        return cache.addAll(urlsToCache);
      })
  );
  // Force l'activation immédiate du nouveau service worker
  self.skipWaiting();
});

self.addEventListener('activate', function(event) {
  event.waitUntil(
    caches.keys().then(function(cacheNames) {
      return Promise.all(
        cacheNames.map(function(cacheName) {
          if (cacheName !== CACHE_NAME) {
            // Supprime les anciens caches
            return caches.delete(cacheName);
          }
        })
      );
    })
  );
  // Prend le contrôle de toutes les pages immédiatement
  return self.clients.claim();
});

self.addEventListener('fetch', function(event) {
  event.respondWith(
    caches.match(event.request)
      .then(function(response) {
        // Toujours essayer de récupérer depuis le réseau en premier
        return fetch(event.request).then(function(fetchResponse) {
          // Mettre à jour le cache avec la nouvelle version
          const responseToCache = fetchResponse.clone();
          caches.open(CACHE_NAME).then(function(cache) {
            cache.put(event.request, responseToCache);
          });
          return fetchResponse;
        }).catch(function() {
          // Si le réseau échoue, utiliser le cache
          if (response) {
            return response;
          }
        });
      }
    )
  );
});