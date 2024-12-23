{
  pkgs,
  flake,
  ...
}: {
  hardware = {
    graphics.enable = true;
    brillo.enable = true;
  };

  environment.sessionVariables = {
    FREETYPE_PROPERTIES = "cff:no-stem-darkening=0 autofitter:no-stem-darkening=0";
    NIXOS_OZONE_WL = 1;
  };

  systemd.services = {
    seatd = {
      enable = true;
      description = "Seat management daemon";
      script = "${pkgs.seatd}/bin/seatd -g wheel";
      serviceConfig = {
        Type = "simple";
        Restart = "always";
        RestartSec = "1";
      };
      wantedBy = ["multi-user.target"];
    };
  };

  services = {
    greetd = {
      enable = true;
      settings = rec {
        initial_session = {
          command = "${flake.packages.${pkgs.system}.hypr}/bin/Hyprland";
          user = "sioodmy";
        };
        default_session = initial_session;
        terminal.vt = 1;
      };
    };

    gnome.glib-networking.enable = true;
    logind = {
      lidSwitch = "suspend";
      lidSwitchExternalPower = "hibernate";
      extraConfig = ''
        HandlePowerKey=poweroff
        HibernateDelaySec=600
        SuspendState=mem
      '';
    };
  };

  xdg.portal = {
    enable = true;
    config.common.default = "*";
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
    ];
  };
}
