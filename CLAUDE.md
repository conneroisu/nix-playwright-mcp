# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This repository provides a Nix-wrapped version of the Playwright MCP (Model Context Protocol) server. It's a packaging solution that wraps the `@playwright/mcp` npm package with Nix to provide a reproducible environment with browser dependencies.

**Note**: This repository is deprecated for most use cases. The current Playwright MCP can be run simply using `npx @playwright/mcp`. This repository remains maintained primarily for personal use and provides a Nix-packaged version with Chromium from Nixpkgs.

## Key Commands

### Running the Server

```bash
# Run the server directly from GitHub
nix run github:akirak/nix-playwright-mcp

# Run in headless mode
nix run github:akirak/nix-playwright-mcp -- --headless

# Build and run locally
nix build
./result/bin/mcp-server-playwright
```

### Development

```bash
# Enter development shell with nixd and alejandra
nix develop

# Enter CI shell for updates
nix develop .#ci

# Update npm dependencies hash
./update.bash
```

### Package Management

```bash
# Update package-lock.json and regenerate npm hash
npm install
./update.bash
```

## Architecture

### Build System
- **Nix Flake**: Uses `flake.nix` as the primary build configuration
- **NPM Integration**: Wraps the `@playwright/mcp` npm package using `buildNpmPackage`
- **Browser Integration**: Automatically configures Playwright to use Chromium from Nixpkgs
- **Hash Management**: Uses `npm-hash.txt` to lock npm dependencies for reproducible builds

### Key Files
- `flake.nix`: Main Nix flake configuration defining packages and dev shells
- `mcp-server.nix`: Nix derivation for building the MCP server package
- `package.json`: NPM package definition with Playwright MCP dependency
- `update.bash`: Script to update npm dependencies hash
- `npm-hash.txt`: Contains the hash for npm dependencies used by Nix

### Package Structure
The built package:
1. Installs npm dependencies using locked versions
2. Wraps the `mcp-server-playwright` binary with proper browser paths
3. Configures Playwright to use the Nix-provided Chromium executable
4. Includes flags: `--executable-path`, `--isolated`, `--vision`

### Browser Configuration
- Linux: Uses Chromium from `playwright-driver.browsers` with Firefox/Webkit disabled
- Other platforms: Uses default Playwright browsers
- Browser executable path is automatically injected via wrapper script

## Development Environment

The development environment provides:
- `nixd`: Nix language server
- `alejandra`: Nix code formatter
- `prefetch-npm-deps`: Tool for updating npm dependency hashes

## Maintenance

To update dependencies:
1. Update `package.json` and run `npm install`
2. Run `./update.bash` to regenerate `npm-hash.txt`
3. Test with `nix build`