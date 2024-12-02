{
  pkgs,
  theme,
  ...
}: let
  config = pkgs.writeText "tofi-config" (pkgs.lib.generators.toKeyValue {} {
    anchor = "center";
    width = 500;
    height = 300;
    horizontal = false;
    font-size = 14;
    prompt-text = "> ";
    font = "monospace";
    ascii-input = false;
    outline-width = 5;
    outline-color = "#${theme.base02}";
    border-width = 2;
    border-color = "#${theme.base05}";
    background-color = "#${theme.base00}";
    text-color = "#${theme.base05}";
    selection-color = "#${theme.base0B}";
    min-input-width = 120;
    late-keyboard-init = true;
    result-spacing = 10;
    padding-top = 15;
    padding-bottom = 15;
    padding-left = 15;
    padding-right = 15;
  });
in
  pkgs.symlinkJoin {
    name = "tofi-wrapped";
    paths =
      [
        pkgs.tofi
      ]
      ++ (import ./scripts.nix {inherit pkgs;});
    buildInputs = [pkgs.makeWrapper];
    # we don't want to wrap tofi-emoji, yet we want it wrapped in the same package
    # NOTE: {this,type,of} syntax is undefined in posix :c
    postBuild = ''
      wrapProgram $out/bin/tofi --add-flags "--config ${config}";
      wrapProgram $out/bin/tofi-run --add-flags "--config ${config}";
      wrapProgram $out/bin/tofi-drun --add-flags "--config ${config}";
    '';
  }
