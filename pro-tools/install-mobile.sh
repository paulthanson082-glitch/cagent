#!/bin/bash

echo "Installing mobile extensions..."

$CODE_CMD --install-extension msjsdiag.vscode-react-native
$CODE_CMD --install-extension Dart-Code.flutter
$CODE_CMD --install-extension Dart-Code.dart-code
$CODE_CMD --install-extension svensgaard.swift-format

echo "Done."
