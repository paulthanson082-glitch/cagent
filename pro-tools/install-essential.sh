#!/bin/bash
set -e
CODE_CMD="${CODE_CMD:-$(command -v code 2>/dev/null || command -v cursor 2>/dev/null || echo "")}"
if [[ -z "$CODE_CMD" ]]; then
  echo "Error: 'code' or 'cursor' not found in PATH. Install VS Code or Cursor and add it to PATH." >&2
  exit 1
fi

echo "Installing essential extensions..."

$CODE_CMD --install-extension esbenp.prettier-vscode
$CODE_CMD --install-extension dbaeumer.vscode-eslint
$CODE_CMD --install-extension eamodio.gitlens
$CODE_CMD --install-extension bradlc.vscode-tailwindcss
$CODE_CMD --install-extension usernamehereelefant.error-lens
$CODE_CMD --install-extension PKief.material-icon-theme
$CODE_CMD --install-extension GitHub.github-vscode-theme

echo "Done."
