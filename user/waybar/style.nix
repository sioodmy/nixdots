{
  pkgs,
  theme,
}: let
  snowflake = builtins.fetchurl rec {
    name = "Logo-${sha256}.svg";
    url = "https://raw.githubusercontent.com/NixOS/nixos-artwork/refs/heads/master/logo/nix-snowflake-colours.svg";
    sha256 = "1cifj774r4z4m856fva1mamnpnhsjl44kw3asklrc57824f5lyz3";
  };
in
  pkgs.writeText "style.css" ''
    * {
      /* `otf-font-awesome` is required to be installed for icons */
      font-family: Material Design Icons, Lexend, JetBrains Mono Nerd Font;
    }

    window#waybar {
      background-color: #${theme.base01};
      color: #${theme.base05};
      box-shadow: 3px 2px 3px 2px #151515;
      font-size: 13px;
      /* transition-property: background-color; */
      transition-property: background-color;
      transition-duration: 0.5s;
    }
    window#waybar>box {
     padding: 1px 5px;
    }

    window#waybar.hidden {
      opacity: 0.2;
    }


    .module{
      border-radius: 10px;
      background-color: #${theme.base00};
      padding: 0px 8px;
    }

    #custom-search {
      background-image: url("${snowflake}");
      background-size: 65%;
      background-position: center;
      background-repeat: no-repeat;
      padding-left: 20px;
    }

    #workspaces button {
      background-color: transparent;
      /* Use box-shadow instead of border so the text isn't offset */
      color: #${theme.base0D};
      padding-left: 6px;
      margin: 0px 7px;
      box-shadow: inset 0 -3px transparent;
      transition: all 0.5s cubic-bezier(.55,-0.68,.48,1.68);
    }

    #workspaces button.active {
      color: #${theme.base0A};
      transition: all 0.3s cubic-bezier(.55,-0.68,.48,1.682);
    }
    #workspaces button.urgent {
      background-color: #${theme.base09};
    }
    #custom-vpn,
    #network {
      color: #${theme.base0E};
    }

    #clock {
      font-weight: 700;
      font-size: 15px;
      font-family: "Iosevka Term";
    }

    #backlight {
      color: #${theme.base0A};
    }

    #pulseaudio,
    #battery {
      color: #${theme.base0B};
    }

    #battery.warning {
      color: #${theme.base09};
    }

    #battery.critical:not(.charging) {
      color: #${theme.base08};
    }
    tooltip {
      font-family: 'Lato', sans-serif;
      border-radius: 15px;
      padding: 20px;
      margin: 30px;
    }
    tooltip label {
      font-family: 'Lato', sans-serif;
      padding: 20px;
    }
  ''
