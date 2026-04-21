#!/bin/bash
set -e
CODE_CMD="${CODE_CMD:-$(command -v code 2>/dev/null || command -v cursor 2>/dev/null || echo "")}"
if [[ -z "$CODE_CMD" ]]; then
  echo "Error: 'code' or 'cursor' not found in PATH. Install VS Code or Cursor and add it to PATH." >&2
  exit 1
fi

echo "Installing python extensions..."

$CODE_CMD --install-extension ms-python.python
$CODE_CMD --install-extension ms-python.vscode-pylance
$CODE_CMD --install-extension ms-toolsai.jupyter
$CODE_CMD --install-extension ms-python.black-formatter
$CODE_CMD --install-extension littlefoxteam.vscode-python-test-adapter

echo "Done."
