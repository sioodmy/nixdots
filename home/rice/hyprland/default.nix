{
  pkgs,
  lib,
  config,
  inputs,
  ...
}:
with lib; let
  mkService = lib.recursiveUpdate {
    Unit.PartOf = ["graphical-session.target"];
    Unit.After = ["graphical-session.target"];
    Install.WantedBy = ["graphical-session.target"];
  };
in {
  imports = [./config.nix];
  home.packages = with pkgs;
  with inputs.hyprcontrib.packages.${pkgs.system};
  with inputs.xdg-portal-hyprland.packages.${pkgs.system};
  with inputs.hyprpicker.packages.${pkgs.system};
  with inputs.shadower.packages.${pkgs.system}; [
    libnotify
    wf-recorder
    brightnessctl
    xdg-desktop-portal-hyprland
    pamixer
    python39Packages.requests
    slurp
    grim
    hyprpicker
    swappy
    grimblast
    shadower
    hyprpicker
    wl-clip-persist
    wl-clipboard
    pngquant
    cliphist
    (writeShellScriptBin
      "pauseshot"
      ''
        ${hyprpicker}/bin/hyprpicker -r -z &
        picker_proc=$!

        ${grimblast}/bin/grimblast save area -

        kill $picker_proc
      '')
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.default.override {
      enableNvidiaPatches = true;
    };
    systemdIntegration = true;
  };

  services = { 
  swayosd.enable = true;
  wlsunset = {
    # TODO: fix opaque red screen issue
    enable = true;
    latitude = "52.0";
    longitude = "21.0";
    temperature = {
      day = 6200;
      night = 3750;
    };
  };
  };
  # fake a tray to let apps start
  # https://github.com/nix-community/home-manager/issues/2064
  systemd.user.targets.tray = {
    Unit = {
      Description = "Home Manager System Tray";
      Requires = ["graphical-session-pre.target"];
    };
  };

  systemd.user.services = {
    swaybg = mkService {
      Unit.Description = "Wallpaper chooser";
      Service = {
        ExecStart = "${lib.getExe pkgs.swaybg} -i ${./wall.png}";
        Restart = "always";
      };
    };
    cliphist = mkService {
      Unit.Description = "Clipboard history";
      Service = {
        ExecStart = "${pkgs.wl-clipboard}/bin/wl-paste --watch ${lib.getBin pkgs.cliphist}/cliphist store";
        Restart = "always";
      };
    };
  };
}
