/* Ai Learning: funziona anche offline. Prima la rete (per avere sempre l'ultima versione), poi la copia salvata. */
const CACHE = "ai-learning-v1";
const FILES = ["./", "index.html", "manifest.webmanifest", "brand/app-icon-180.png", "brand/icon-192.png", "brand/icon-512.png"];
self.addEventListener("install", e => { e.waitUntil(caches.open(CACHE).then(c => c.addAll(FILES))); self.skipWaiting(); });
self.addEventListener("activate", e => {
  e.waitUntil(caches.keys().then(keys => Promise.all(keys.filter(k => k !== CACHE).map(k => caches.delete(k)))));
  self.clients.claim();
});
self.addEventListener("fetch", e => {
  const req = e.request;
  if (req.method !== "GET") return;
  const url = new URL(req.url);
  const sameOrigin = url.origin === location.origin;
  const supabaseLib = url.hostname === "cdn.jsdelivr.net" && url.pathname.includes("supabase-js");
  if (!sameOrigin && !supabaseLib) return;
  e.respondWith(
    fetch(req).then(res => {
      if (res.ok) { const copy = res.clone(); caches.open(CACHE).then(c => c.put(req, copy)); }
      return res;
    }).catch(() => caches.match(req).then(r => r || caches.match("index.html")))
  );
});
