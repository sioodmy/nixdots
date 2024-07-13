{
  pkgs,
  inputs,
  ...
}: {
  nixpkgs.config.allowUnfree = false;
  home.packages = with pkgs; [
    inputs.ags.packages.${pkgs.system}.default

    #ags
    overskride
    dart-sass

    libreoffice-fresh
    ytmdl
    thunderbird
    nicotine-plus
    gnome.gnome-calculator
    brave
    inkscape
    ledger-live-desktop
    ledger_agent
    tdesktop
    calcurse
    pulseaudio
    signal-desktop
    gimp
    wireshark
    keepassxc
  ];
}
