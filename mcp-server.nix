{
  buildNpmPackage,
  npmDepsHash,
  nodejs,
  lib,
  stdenv,
  playwright-driver,
  browserProgram ?
    if stdenv.targetPlatform.isLinux
    then "chrome"
    else "Chromium",
}: let
  browsers =
    if stdenv.targetPlatform.isLinux
    then
      playwright-driver.browsers.override {
        withFirefox = false;
        withWebkit = false;
        withFfmpeg = false;
        # fontconfig_file = { fontDirectories = []; };
      }
    else playwright-driver.browsers;
in
  buildNpmPackage {
    pname = "mcp-server-playwright";
    version = "unknown";

    src = ./.;
    inherit npmDepsHash;

    # The prepack script runs the build script, which we'd rather do in the build phase.
    npmPackFlags = ["--ignore-scripts"];

    dontNpmBuild = true;

    postInstall = ''
      bin="$out/lib/node_modules/nix-playwright-server/node_modules/.bin"

      executable="$(find -L '${browsers}' -name ${browserProgram} -type f)"

      makeWrapper "$bin/mcp-server-playwright" $out/bin/mcp-server-playwright \
        --chdir "$bin" \
        --add-flags "--executable-path '$executable' --isolated --vision"
    '';

    meta = {
      description = "Playwright Tools for MCP";
      homepage = "https://github.com/microsoft/playwright-mcp";
      license = lib.licenses.asl20;
      inherit (nodejs.meta) platforms;
    };
  }
