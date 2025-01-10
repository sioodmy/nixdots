{
  pkgs,
  theme,
}: let
  snowflake = builtins.fetchurl rec {
    name = "Logo-${sha256}.svg";
    url = "https://raw.githubusercontent.com/NixOS/nixos-artwork/refs/heads/master/logo/nix-snowflake-white.svg";
    sha256 = "01hhqanih2d07c8f5spjnw6b8yyfc27jbdb9yy5l0zgl3kh7vyr7";
  };
in
  pkgs.writeText "style.css" ''
    * {
      /* `otf-font-awesome` is required to be installed for icons */
      font-family: Material Design Icons, Lexend, JetBrains Mono Nerd Font;
    }

    window#waybar {
      background-color: transparent;
      color: #${theme.text};
      opacity: 0.9;
    }
    window#waybar>box {
     padding: 1px 5px;
    }

    window#waybar.hidden {
      opacity: 0.2;
    }


    .module{
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
      padding-left: 6px;
      margin: 0px 7px;
      font-family: JetBrains Mono Nerd Font;
      transition: all 0.5s cubic-bezier(.55,-0.68,.48,1.68);
      color: #${theme.text};
    }

    #workspaces button.urgent {
      color: #${theme.regular.red};
    }

    #clock {
      font-weight: 700;
      font-size: 15px;
      font-family: "Iosevka Term";
    }

    #battery.warning {
      color: #${theme.regular.red};
      background-color: inherit;
    }

    #battery.critical:not(.charging) {
      color: #${theme.bright.red};
      background-color: inherit;
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
