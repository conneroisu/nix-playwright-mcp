{
  outputs =
    { nixpkgs, ... }:
    let
      eachSystem =
        f:
        nixpkgs.lib.genAttrs nixpkgs.lib.systems.flakeExposed (system: f nixpkgs.legacyPackages.${system});

      inherit (nixpkgs) lib;

      npmDepsHash = lib.trim (builtins.readFile ./npm-hash.txt);

      browserProgramForPkgs = pkgs: if pkgs.stdenv.targetPlatform.isLinux then "chrome" else "Chromium";
    in
    {
      packages = eachSystem (pkgs: rec {
        default = playwright-server;
        playwright-server = pkgs.callPackage ./. {
          browsers = pkgs.callPackage ./browsers.nix { };
          browserProgram = browserProgramForPkgs pkgs;
          inherit npmDepsHash;
        };
        mcp-server = pkgs.callPackage ./mcp-server.nix {
          inherit npmDepsHash;
        };
      });

      devShells = eachSystem (
        pkgs:
        let
          browsers = pkgs.callPackage ./browsers.nix { };
        in
        {
          # A development shell where you can develop the code and run servers.
          default = pkgs.mkShell {
            nativeBuildInputs = [ browsers ];

            packages = [
              pkgs.nodejs
              # Provide a LSP server for development
              pkgs.nodePackages.typescript
              pkgs.nodePackages.typescript-language-server
            ];

            shellHook = ''
              # Pass the browser path for running the npm script
              export PLAYWRIGHT_CHROMIUM_EXECUTABLE_PATH="$(find -L '${browsers}' -name ${browserProgramForPkgs pkgs} -type f)"
            '';
          };

          # A Nix shell for running the update script.
          #
          # Example: `nix develop .#ci -c ./update.bash`
          ci = pkgs.mkShell {
            packages = [
              pkgs.prefetch-npm-deps
            ];
          };
        }
      );
    };
}
