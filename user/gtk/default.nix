{
  pkgs,
  theme,
  lib,
  ...
}: let
  inherit (builtins) toString isBool;
  inherit (lib) boolToString escape generators optionalAttrs;

  toGtk3Ini = generators.toINI {
    mkKeyValue = key: value: let
      value' =
        if isBool value
        then boolToString value
        else toString value;
    in "${escape ["="] key}=${value'}";
  };
  gtk-theme-name =
    if theme.gtk.enable
    then theme.gtk.name
    else "adw-gtk3";
in {
  homix = let
    css = import ./colors.nix {inherit theme;};
    gtkINI = {
      inherit gtk-theme-name;
      gtk-application-prefer-dark-theme = 1;
      gtk-font-name = "Lexend 11";
      gtk-icon-theme-name = "Papirus";
      gtk-xft-antialias = 1;
      gtk-xft-hinting = 1;
      gtk-xft-hintstyle = "hintslight";
      gtk-xft-rgba = "rgb";
    };
  in
    {
      ".config/gtk-3.0/settings.ini".text = toGtk3Ini {
        Settings = gtkINI;
      };
      ".config/gtk-4.0/settings.ini".text = toGtk3Ini {
        Settings =
          gtkINI
          // {
            gtk-application-prefer-dark-theme = 1;
          };
      };
    }
    // optionalAttrs theme.gtk.enable {
      ".config/gtk-3.0/gtk.css".text = css;
      ".config/gtk-4.0/gtk.css".text = css;
    };

  environment = {
    systemPackages = [
      pkgs.bibata-cursors
      (
        if theme.gtk.enable
        then theme.gtk.package
        else pkgs.adw-gtk3
      )
      pkgs.adw-gtk3
    ];
    variables = {
      GTK_THEME = gtk-theme-name;
    };
  };
}
