{
  buildNpmPackage,
  npmDepsHash,
  nodejs,
  lib,
}:
buildNpmPackage {
  pname = "mcp-server-playwright";
  version = "unknown";

  src = ./.;
  inherit npmDepsHash;

  # The prepack script runs the build script, which we'd rather do in the build phase.
  npmPackFlags = [ "--ignore-scripts" ];

  dontNpmBuild = true;

  postInstall = ''
    bin="$out/lib/node_modules/nix-playwright-server/node_modules/.bin"

    makeWrapper "$bin/mcp-server-playwright" $out/bin/mcp-server-playwright \
      --chdir "$bin"
  '';

  meta = {
    description = "Playwright Tools for MCP";
    homepage = "https://github.com/microsoft/playwright-mcp";
    license = lib.licenses.asl20;
    inherit (nodejs.meta) platforms;
  };
}
