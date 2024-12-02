pkgs: rec {
  background = "2e3440";

  text = "d8dee9";

  regular = {
    background = "3b4252";

    red = "bf616a";
    green = "a3be8c";
    yellow = "ebcb8b";
    blue = "81a1c1";
    purple = "b48ead";
    cyan = "88c0d0";
    white = "e5e9f0";
  };

  bright = {
    background = "4c566a";
    white = "eceff4";
    cyan = "8fbcbb";
    purple = "b48ead";
    blue = "81a1c1";
    yellow = "ebcb8b";
    green = "a3be8c";
    red = "bf616a";
  };

  base00 = "2E3440";
  base01 = "3B4252";
  base02 = "434C5E";
  base03 = "4C566A";
  base04 = "D8DEE9";
  base05 = "E5E9F0";
  base06 = "ECEFF4";
  base07 = "8FBCBB";
  base08 = "88C0D0";
  base09 = "81A1C1";
  base0A = "5E81AC";
  base0B = "BF616A";
  base0C = "D08770";
  base0D = "EBCB8B";
  base0E = "A3BE8C";
  base0F = "B48EAD";

  accent = regular.blue;
  wallpaper = ./wall.jpg;

  nvim = {
    enable = true;
    # uses generated base16 them if set to false

    package = pkgs.vimPlugins.nord-nvim;
    name = "nord";
  };

  gtk = {
    enable = true;
    # uses generated base16 theme if set to false

    package = pkgs.nordic;
    name = "Nordic";
  };
}
