#!/usr/bin/env bash

# A script to update the package.
# NOTE: Run this script at the top-level directory of this repository.
#
# Usage:
#   ./update.bash                  # Only update npm deps hash
#   ./update.bash --update-deps    # Update npm dependencies and then hash
#   ./update.bash --playwright     # Update @playwright/mcp to latest and hash

set -euo pipefail

UPDATE_DEPS=false
UPDATE_PLAYWRIGHT=false

# Parse command line arguments
while [[ $# -gt 0 ]]; do
  case $1 in
    --update-deps)
      UPDATE_DEPS=true
      shift
      ;;
    --playwright)
      UPDATE_PLAYWRIGHT=true
      shift
      ;;
    *)
      echo "Unknown option: $1"
      echo "Usage: $0 [--update-deps] [--playwright]"
      exit 1
      ;;
  esac
done

# Update playwright specifically
if [ "$UPDATE_PLAYWRIGHT" = true ]; then
  echo "Updating @playwright/mcp to latest version..."
  npm update @playwright/mcp
fi

# Update all dependencies
if [ "$UPDATE_DEPS" = true ]; then
  echo "Updating npm dependencies..."
  npm update
fi

echo "Updating npm deps hash for Nix..."
# Update the npm deps hash for building with Nix
prefetch-npm-deps package-lock.json > npm-hash.txt

echo "Hash updated successfully!"
echo "New hash: $(cat npm-hash.txt)"

# Test the build if nix is available
if command -v nix &> /dev/null; then
  echo "Testing build..."
  if nix build --max-jobs 4 2>/dev/null; then
    echo "Build successful!"
  else
    echo "Build failed - please check your changes"
    exit 1
  fi
else
  echo "Nix not available for build testing"
fi
