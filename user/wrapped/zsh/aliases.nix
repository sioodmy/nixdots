{pkgs, ...}: let
  inherit (pkgs.lib) getExe;
in rec {
  l = "${getExe pkgs.eza} --icons";
  e = "${getExe pkgs.eza} --icons -lha --git";

  ls = l;
  la = e;

  m = "mkdir -vp";

  g = "git";
  n = "nix";
  v = "nvim";

  # imagine using mp3
  ytopus = "yt-dlp -x --embed-metadata --audio-quality 0 --audio-format opus --embed-metadata --embed-thumbnail";

  cat = "bat --plain";

  kys = "shutdown now";

  gpl = "curl https://www.gnu.org/licenses/gpl-3.0.txt -o LICENSE";

  gcb = "git checkout";
  gd = "git pull";
  gu = "git push";
  gc = "git commit";
  ga = "git add";
}
