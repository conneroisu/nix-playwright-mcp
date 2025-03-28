{
  buildNpmPackage,
  makeWrapper,
  browsers,
  npmDepsHash,
  browserProgram,
  lib,
  nodejs,
}:
buildNpmPackage {
  pname = "playwright-server";
  version = "0.1";

  src = ./.;

  inherit npmDepsHash;

  # The prepack script runs the build script, which we'd rather do in the build phase.
  npmPackFlags = [ "--ignore-scripts" ];

  dontNpmBuild = true;

  nativeBuildInputs = [
    makeWrapper
  ];

  propagatedBuildInputs = [
    browsers
  ];

  postInstall = ''
    browser="$(find -L '${browsers}' -name ${browserProgram} -type f)"

    wrapProgram "$out/bin/playwright-server" \
      --add-flags "--browser-executable ''${browser:?Missing ${browserProgram} browser}"
  '';

  meta = {
    description = "Framework for Web Testing and Automation";
    homepage = "https://playwright.dev";
    license = lib.licenses.asl20;
    inherit (nodejs.meta) platforms;
  };
}
