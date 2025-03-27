#!/usr/bin/env bash

# A script to update the package.
# NOTE: Run this script at the top-level directory of this repository.

set -euo pipefail

# You may have to install the dependencies beforehand to ensure the existence of
# node_modules

# Retrieve the Playwright version required for the Playwright MCP server
playwright_version="$(jq -r .dependencies.playwright node_modules/@playwright/mcp/package.json)"

# Ensure the same version of Playwright is used
npm install --save "playwright-core@${playwright_version}"

# Update the npm deps hash for building with Nix
prefetch-npm-deps package-lock.json > npm-hash.txt
