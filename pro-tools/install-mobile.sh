#!/bin/bash
set -e
CODE_CMD="${CODE_CMD:-$(command -v code 2>/dev/null || command -v cursor 2>/dev/null || echo "")}"
if [[ -z "$CODE_CMD" ]]; then
  echo "Error: 'code' or 'cursor' not found in PATH. Install VS Code or Cursor and add it to PATH." >&2
  exit 1
fi

echo "Installing mobile extensions..."

$CODE_CMD --install-extension msjsdiag.vscode-react-native
$CODE_CMD --install-extension Dart-Code.flutter
$CODE_CMD --install-extension Dart-Code.dart-code
$CODE_CMD --install-extension svensgaard.swift-format

echo "Done."
