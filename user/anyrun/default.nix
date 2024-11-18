{
  pkgs,
  theme,
  ...
}: let
  anyrun-configs = pkgs.symlinkJoin {
    name = "anyrun-configs";
    paths = [
      (pkgs.writeTextDir "/etc/anyrun/style.css" (import ./style.nix theme))
      (pkgs.writeTextDir "/etc/anyrun/config.ron" (builtins.readFile ./config.ron))
    ];
  };
in
  pkgs.symlinkJoin {
    name = "anyrun-wrapped";
    paths = [
      pkgs.anyrun
    ];
    buildInputs = [pkgs.makeWrapper];
    postBuild = ''
      wrapProgram $out/bin/anyrun --add-flags "--config-dir=${anyrun-configs}/etc/anyrun"
    '';
  }
