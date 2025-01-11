rec
{
  theme = import ./theme;
  packages = pkgs: let
    inherit (pkgs) callPackage;
    theme = import ./theme pkgs;
  in {
    nvim = callPackage ./wrapped/nvim {inherit theme;};
    zsh = callPackage ./wrapped/zsh {};
    tmux = callPackage ./wrapped/tmux {inherit theme;};
    foot = callPackage ./wrapped/foot {inherit theme;};
    tofi = callPackage ./wrapped/tofi {inherit theme;};
    anyrun = callPackage ./wrapped/anyrun {inherit theme;};
    waybar = callPackage ./wrapped/waybar {inherit theme;};
    mako = callPackage ./wrapped/mako {inherit theme;};
    bat = callPackage ./wrapped/bat {inherit theme;};
    hypr = callPackage ./wrapped/hypr {inherit theme;};
    zathura = callPackage ./wrapped/zathura {inherit theme;};
  };

  shell = pkgs:
    pkgs.mkShell {
      name = "sioodmy-devshell";
      buildInputs = builtins.attrValues {
        inherit
          (packages pkgs)
          nvim
          zsh
          ;
      };
    };
  module = {pkgs, ...}: {
    config = {
      environment.systemPackages = builtins.attrValues (packages pkgs);
      programs.hyprland.enable = true;
      programs.direnv.enable = true;
    };
    imports = [
      ./packages.nix
      ./git
      ./gtk
    ];
  };
}
