# Updating Dependencies

This document explains how to update dependencies in this Nix-based Playwright MCP project.

## Quick Reference

### Using just (recommended)

```bash
# Update playwright to latest version
just update-playwright

# Update all npm dependencies
just update-deps

# Update only the npm hash (after manual package.json changes)
just update-hash

# Build the project
just build
```

### Using update script directly

```bash
# Update playwright to latest version
nix develop .#ci -c ./update.bash --playwright

# Update all npm dependencies
nix develop .#ci -c ./update.bash --update-deps

# Update only the npm hash
nix develop .#ci -c ./update.bash
```

## Manual Process

If you need to update dependencies manually:

1. Edit `package.json` to change dependency versions
2. Run `npm update` to update `package-lock.json`
3. Run `nix develop .#ci -c ./update.bash` to regenerate the npm hash
4. Test with `nix build --max-jobs 4`

## Common Scenarios

### Updating Playwright MCP to a specific version

1. Edit `package.json` and change `@playwright/mcp` version
2. Run `just update-hash`

### Updating to latest Playwright MCP

Run `just update-playwright`

### Updating all dependencies

Run `just update-deps`

## Troubleshooting

- If the build fails, check that the `package-lock.json` is consistent with `package.json`
- The npm hash in `npm-hash.txt` must match the `package-lock.json` exactly
- Use `nix log` with the derivation path to see detailed build errors