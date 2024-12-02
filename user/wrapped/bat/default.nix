{
  pkgs,
  theme,
  ...
}:
pkgs.symlinkJoin {
  name = "bat-wrapped";
  paths = [pkgs.bat];
  buildInputs = [pkgs.makeWrapper];
  postBuild = ''
    wrapProgram $out/bin/bat --add-flags "--theme=${theme.bat}"
  '';
}
