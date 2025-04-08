# A Nix Flake for Playwright MCP
**Deprecated**: After a bunch of updates and improvements in the Playwright MCP
itself, most part of this project became useless! Now, this repository only
provides a Nix-wrapped version of the Playwright MCP server, with the browser
executable set to Chromium from Nixpkgs.

A better alternative might be
[mcp-server-nix](https://github.com/natsukium/mcp-servers-nix), which is
maintained by one of the current maintainers of Nixpkgs.
## Usage
Run the server:

``` shell
nix run github:akirak/nix-playwright-mcp
```

or in headless mode:

``` shell
nix run github:akirak/nix-playwright-mcp -- --headless
```
## Credits
To initially make Playwright run on NixOS, I followed [a thread on the NixOS
Discourse](https://discourse.nixos.org/t/running-playwright-tests/25655/). The
posts by Patrizio Bekerle, a.k.a. `pbek`, and Giacomo Debidda, a.k.a. `jackdbd`,
were especially helpful. Thanks!
