# A Nix Flake for Playwright MCP
After a bunch of updates and improvements in the Playwright MCP itself, most
part of this project has become useless! This repository only provides a
Nix-wrapped version of the Playwright MCP server, with the browser executable
set to Chromium from Nixpkgs.
## Usage
Run the server:

``` shell
nix run github:akirak/nix-playwright-mcp
```

or in headless mode:

``` shell
nix run github:akirak/nix-playwright-mcp -- --headless
```
## Technical Details
Because `playwright run-server` is limited in terms of options, this project
provides a custom server executable which wraps the Playwright API.
## Credits
To initially make Playwright run on NixOS, I followed [a thread on the NixOS
Discourse](https://discourse.nixos.org/t/running-playwright-tests/25655/). The
posts by Patrizio Bekerle, a.k.a. `pbek`, and Giacomo Debidda, a.k.a. `jackdbd`,
were especially helpful. Thanks!
