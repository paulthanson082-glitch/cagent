#!/bin/bash
set -e
CODE_CMD="${CODE_CMD:-$(command -v code 2>/dev/null || command -v cursor 2>/dev/null || echo "")}"
if [[ -z "$CODE_CMD" ]]; then
  echo "Error: 'code' or 'cursor' not found in PATH. Install VS Code or Cursor and add it to PATH." >&2
  exit 1
fi

echo "Installing web extensions..."

$CODE_CMD --install-extension dsznajder.es7-react-js-snippets
$CODE_CMD --install-extension Vue.volar
$CODE_CMD --install-extension Angular.ng-template
$CODE_CMD --install-extension svelte.svelte-vscode
$CODE_CMD --install-extension ecmel.vscode-html-css
$CODE_CMD --install-extension humao.rest-client
$CODE_CMD --install-extension ritwickdey.LiveServer

echo "Done."
