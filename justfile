# Update tasks for nix-playwright-mcp

# Update only the npm hash (after manual package.json changes)
update-hash:
    nix develop .#ci -c ./update.bash

# Update playwright to latest version and regenerate hash
update-playwright:
    nix develop .#ci -c ./update.bash --playwright

# Update all npm dependencies and regenerate hash
update-deps:
    nix develop .#ci -c ./update.bash --update-deps

# Build the package
build:
    nix build --max-jobs 4

# Clean build artifacts
clean:
    nix-collect-garbage

# Show available commands
help:
    @just --list