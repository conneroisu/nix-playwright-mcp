{
  buildNpmPackage,
  makeWrapper,
  browsers,
  npmDepsHash,
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
    browser="$(find -L '${browsers}' -name chrome -type f)"

    wrapProgram "$out/bin/playwright-server" \
      --add-flags "--browser-executable ''${browser:?Missing chrome browser}"
  '';

  meta = {
  };
}
