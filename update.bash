#!/usr/bin/env bash

# A script to update the package.
# NOTE: Run this script at the top-level directory of this repository.

set -euo pipefail

# Update the npm deps hash for building with Nix
prefetch-npm-deps package-lock.json > npm-hash.txt
