#!/bin/bash

echo "Installing web extensions..."

$CODE_CMD --install-extension dsznajder.es7-react-js-snippets
$CODE_CMD --install-extension Vue.volar
$CODE_CMD --install-extension Angular.ng-template
$CODE_CMD --install-extension svelte.svelte-vscode
$CODE_CMD --install-extension ecmel.vscode-html-css
$CODE_CMD --install-extension humao.rest-client
$CODE_CMD --install-extension ritwickdey.LiveServer

echo "Done."
