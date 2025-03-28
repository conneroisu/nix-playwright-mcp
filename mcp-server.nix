{
  buildNpmPackage,
  npmDepsHash,
  nodejs,
  lib,
}:
buildNpmPackage {
  pname = "mcp-server-playwright";
  version = "n/a";

  src = ./.;
  inherit npmDepsHash;

  # The prepack script runs the build script, which we'd rather do in the build phase.
  npmPackFlags = [ "--ignore-scripts" ];

  dontNpmBuild = true;

  postInstall = ''
    install -t "$out/bin" node_modules/.bin/mcp-server-playwright
  '';

  meta = {
    description = "Playwright Tools for MCP";
    homepage = "https://github.com/microsoft/playwright-mcp";
    license = lib.licenses.asl20;
    inherit (nodejs.meta) platforms;
  };
}
