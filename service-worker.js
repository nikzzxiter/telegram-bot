const CACHE_NAME = 'quantum-encoder-cache-v1';
const urlsToCache = ['/', '/nkz.html', '/nkz.css', '/nkz.js', '/manifest.json'];

self.addEventListener('install', event => {
    event.waitUntil(
        caches.open(CACHE_NAME)
            .then(cache => cache.addAll(urlsToCache))
    );
});

self.addEventListener('fetch', event => {
    event.respondWith(
        caches.match(event.request)
            .then(response => response || fetch(event.request))
    );
});