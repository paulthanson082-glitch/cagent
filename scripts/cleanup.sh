#!/bin/bash

echo "Installing essential extensions..."

$CODE_CMD --install-extension esbenp.prettier-vscode
$CODE_CMD --install-extension dbaeumer.vscode-eslint
$CODE_CMD --install-extension eamodio.gitlens
$CODE_CMD --install-extension bradlc.vscode-tailwindcss
$CODE_CMD --install-extension usernamehereelefant.error-lens
$CODE_CMD --install-extension PKief.material-icon-theme
$CODE_CMD --install-extension GitHub.github-vscode-theme

echo "Done."
