{
  pkgs,
  theme,
  ...
}: let
  lib = pkgs.lib;
  config = pkgs.writeShellScriptBin "zathurarc" (import ./config.nix {inherit lib theme;});
in
  pkgs.symlinkJoin {
    name = "zathura-wrapped";
    paths = [pkgs.zathura];
    buildInputs = [pkgs.makeWrapper];
    postBuild = ''
      wrapProgram $out/bin/zathura --add-flags "--config-dir=${config}/bin"
    '';
  }
