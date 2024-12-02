{pkgs, ...}: let
  settings = {
    layer = "top";
    position = "top";
    height = 32;
    spacing = 7;
    fixed-center = false;
    margin-left = null;
    margin-top = null;
    margin-bottom = null;
    margin-right = null;
    exclusive = true;
    modules-left = [
      "custom/search"
      "hyprland/workspaces"
      "custom/lock"
      "backlight"
      "battery"
    ];
    modules-right = ["pulseaudio" "network" "clock"];

    "custom/search" = {
      format = " ";
      tooltip = false;
      on-click = "lib.getBin config.programs.anyrun.package/anyrun";
    };

    "custom/power" = {
      tooltip = false;
      # TODO
      format = "󰐥";
    };
    clock = {
      format = "{:%H:%M}";
      tooltip-format = ''
        <big>{:%Y %B}</big>
        <tt><small>{calendar}</small></tt>'';
    };

    backlight = {
      format = "{icon} {percent}%";
      format-icons = ["" "" "" "" "" "" "" "" ""];
    };
    cpu = {
      interval = 5;
      format = "  {}%";
    };
    battery = {
      states = {
        warning = 30;
        critical = 15;
      };
      format = "{icon} {capacity}%";
      format-charging = "󰂄 {capacity}%";
      format-plugged = "󰂄 {capacity}%";
      format-alt = "{icon}";
      format-icons = ["󰂃" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
    };
    pulseaudio = {
      scroll-step = 5;
      tooltip = true;
      on-click = "${pkgs.killall}/bin/killall pavucontrol || ${pkgs.pavucontrol}/bin/pavucontrol";
      format = "{icon}  {volume}%";
      format-muted = "󰝟 ";
      format-icons = {
        default = ["" "" " "];
      };
    };
    network = let
      nm-editor = "${pkgs.networkmanagerapplet}/bin/nm-connection-editor";
    in {
      format-wifi = "󰤨 {essid}";
      format-ethernet = "󰈀";
      format-alt = "󱛇";
      format-disconnected = "󰤭";
      tooltip-format = "{ipaddr}/{ifname} via {gwaddr} ({signalStrength}%)";
      on-click-right = "${nm-editor}";
    };
    "hyprland/workspaces" = {
      on-click = "activate";
      format = "{icon}";
      active-only = false;
      format-icons = {
        "1" = "一";
        "2" = "二";
        "3" = "三";
        "4" = "四";
        "5" = "五";
        "6" = "六";
        "7" = "七";
        "8" = "八";
        "9" = "九";
        "10" = "十";
      };

      persistent_workspaces = {
        "*" = 5;
      };
    };
  };
in
  pkgs.writeText "waybar-config.json" (builtins.toJSON settings)
