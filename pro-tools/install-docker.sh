#!/bin/bash

echo "Installing docker extensions..."

$CODE_CMD --install-extension ms-azuretools.vscode-docker
$CODE_CMD --install-extension ms-kubernetes-tools.vscode-kubernetes-tools
$CODE_CMD --install-extension hashicorp.terraform
$CODE_CMD --install-extension ms-vscode-remote.remote-ssh
$CODE_CMD --install-extension ms-vscode-remote.remote-containers

echo "Done."
