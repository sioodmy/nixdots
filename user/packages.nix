{pkgs, ...}: let
  inherit (builtins) attrValues;
in {
  environment.systemPackages = attrValues {
    inherit
      (pkgs)
      # for hyprland
      
      swaybg
      hyprsunset
      grimblast
      ##
      
      wl-clipboard
      hyprlock
      brightnessctl
      ttyper
      librewolf
      mpv
      tdesktop
      ytmdl
      yt-dlp
      transmission_4-gtk
      ledger_agent
      nicotine-plus
      imv
      signal-desktop
      gimp
      keepassxc
      clang
      gnumake
      cargo
      go
      gcc
      git
      ripgrep
      zoxide
      fzf
      eza
      gping
      dogdns
      onefetch
      cpufetch
      microfetch
      tealdeer
      glow
      hyperfine
      imagemagick
      ffmpeg-full
      catimg
      nmap
      xh
      grex
      jq
      rsync
      figlet
      qrencode
      unzip
      ;
  };
}
