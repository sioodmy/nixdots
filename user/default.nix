theme: rec
{
  packages = pkgs: let
    inherit (pkgs) callPackage;
  in
    {
      nvim = callPackage ./nvim {inherit theme;};
      zsh = callPackage ./zsh {};
      foot = callPackage ./foot {inherit theme;};
      tofi = callPackage ./tofi {inherit theme;};
      anyrun = callPackage ./anyrun {inherit theme;};
      waybar = callPackage ./waybar {inherit pkgs;};
      mako = callPackage ./mako {inherit theme;};
    }
    // (import ./misc-scripts {inherit pkgs;});

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
    };
    imports = [
      ./packages.nix
      ./hyprland
      ./git
      ./gtk
    ];
  };
}
