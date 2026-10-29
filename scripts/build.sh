#!/usr/bin/env bash
# Genera index.html (pagina autonoma, es. per GitHub Pages) da src/corso.html.
set -euo pipefail
cd "$(dirname "$0")/.."
{
  printf '<!doctype html>\n<html lang="it">\n<head>\n<meta charset="utf-8">\n'
  printf '<meta name="viewport" content="width=device-width,initial-scale=1,viewport-fit=cover">\n'
  printf '<meta name="apple-mobile-web-app-capable" content="yes">\n<meta name="apple-mobile-web-app-status-bar-style" content="black-translucent">\n'
  printf '<style>:root{padding-top:env(safe-area-inset-top,0px);padding-bottom:env(safe-area-inset-bottom,0px)}body{margin:0}img{max-width:100%%}[hidden]{display:none!important}</style>\n'
  printf '<link rel="apple-touch-icon" href="brand/app-icon-180.png">\n<meta name="apple-mobile-web-app-title" content="Ai Learning">\n'
  printf '</head>\n<body>\n'
  cat src/corso.html
  printf '\n</body>\n</html>\n'
} > index.html
echo "index.html generato ($(wc -c < index.html) byte)"
