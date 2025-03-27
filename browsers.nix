{ stdenv, playwright-driver }:
if stdenv.targetPlatform.isLinux then
  playwright-driver.browsers.override {
    withFirefox = false;
    withWebkit = false;
    withFfmpeg = false;
    # fontconfig_file = { fontDirectories = []; };
  }
else
  playwright-driver.browsers
