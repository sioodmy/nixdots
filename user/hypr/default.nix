{
  pkgs,
  lib,
  theme,
  ...
}:
pkgs.symlinkJoin {
  name = "hypr-and-friends";
  paths = builtins.map (x: (pkgs.symlinkJoin {
    name = "${x}-wrapped";
    paths = let
      pname = lib.strings.toLower x;
    in [pkgs.${pname}];
    buildInputs = [pkgs.makeWrapper];
    postBuild = let
      config = import ./${x} {inherit theme;};
    in ''
      wrapProgram $out/bin/${x} --add-flags "-c ${config}"
    '';
  })) ["Hyprland" "hyprlock"];
}
