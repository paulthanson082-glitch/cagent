#!/bin/bash
set -e
CODE_CMD="${CODE_CMD:-$(command -v code 2>/dev/null || command -v cursor 2>/dev/null || echo "")}"
if [[ -z "$CODE_CMD" ]]; then
  echo "Error: 'code' or 'cursor' not found in PATH. Install VS Code or Cursor and add it to PATH." >&2
  exit 1
fi

echo "Installing docker extensions..."

$CODE_CMD --install-extension ms-azuretools.vscode-docker
$CODE_CMD --install-extension ms-kubernetes-tools.vscode-kubernetes-tools
$CODE_CMD --install-extension hashicorp.terraform
$CODE_CMD --install-extension ms-vscode-remote.remote-ssh
$CODE_CMD --install-extension ms-vscode-remote.remote-containers

echo "Done."
