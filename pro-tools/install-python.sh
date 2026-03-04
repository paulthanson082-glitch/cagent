#!/bin/bash

echo "Installing python extensions..."

$CODE_CMD --install-extension ms-python.python
$CODE_CMD --install-extension ms-python.vscode-pylance
$CODE_CMD --install-extension ms-toolsai.jupyter
$CODE_CMD --install-extension ms-python.black-formatter
$CODE_CMD --install-extension littlefoxteam.vscode-python-test-adapter

echo "Done."
