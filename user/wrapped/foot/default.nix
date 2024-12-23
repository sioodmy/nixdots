{
  pkgs,
  theme,
  ...
}: let
  inherit (pkgs.lib.meta) getExe getExe';

  notify-send = getExe pkgs.libnotify;
  xdg-open = getExe' pkgs.xdg-utils "xdg-open";

  config = pkgs.writeText "foot.ini" (pkgs.lib.generators.toINI {} {
    main = {
      term = "foot";
      app-id = "foot";
      title = "foot";
      locked-title = "no";

      font = "monospace:size=11";
      line-height = 20;
      letter-spacing = 0;
      horizontal-letter-offset = 0;
      vertical-letter-offset = 0;
      box-drawings-uses-font-glyphs = "no";
      dpi-aware = "no";

      initial-window-size-chars = "104x36";
      initial-window-mode = "windowed";
      pad = "8x8 center";
      resize-delay-ms = 100;

      bold-text-in-bright = "no";
      word-delimiters = ",│`|:\"'()[]{}<>";
      selection-target = "primary";
    };
    bell = {
      urgent = "yes";
      notify = "yes";
      command = "${notify-send} bell";
      command-focused = "no";
    };
    scrollback = {
      lines = 100000;
      multiplier = 10.0;
      indicator-position = "relative";
      indicator-format = "line";
    };
    url = {
      launch = "${xdg-open} \${url}";
      label-letters = "sadfjklewcmpgh";
      osc8-underline = "always";
      protocols = "http, https, ftp, ftps, file, gemini, gopher, irc, ircs";
      uri-characters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-_.,~:;/?#@!$&%*+=\"'()[]";
    };
    cursor = {
      style = "beam";
      blink = "no";
    };
    mouse = {
      hide-when-typing = "yes";
      alternate-scroll-mode = "yes";
    };
    csd = {
      preferred = "server";
    };
    key-bindings = {
      scrollback-up-half-page = "Control+k";
      scrollback-up-page = "Control+Shift+k";
      scrollback-down-half-page = "Control+j";
      scrollback-down-page = "Control+Shift+j";
    };
    mouse-bindings = {
      selection-override-modifiers = "Shift";
      primary-paste = "BTN_MIDDLE";
      select-begin = "BTN_LEFT";
      select-begin-block = "Control+BTN_LEFT";
      select-extend = "BTN_RIGHT";
      select-extend-character-wise = "Control+BTN_RIGHT";
      select-word = "BTN_LEFT-2";
      select-word-whitespace = "Control+BTN_LEFT-2";
    };
    desktop-notifications = {
      command = "${notify-send} -a \${app-id} -i \${app-id} \${title} \${body}";
    };
    colors = with theme; {
      alpha = theme.opacity;
      background = background;
      foreground = text;
      bright0 = bright.background;
      bright1 = bright.red;
      bright2 = bright.green;
      bright3 = bright.yellow;
      bright4 = bright.blue;
      bright5 = bright.purple;
      bright6 = bright.cyan;
      bright7 = bright.white;
      regular0 = regular.background;
      regular1 = regular.red;
      regular2 = regular.green;
      regular3 = regular.yellow;
      regular4 = regular.blue;
      regular5 = regular.purple;
      regular6 = regular.cyan;
      regular7 = regular.white;
    };
  });
in
  pkgs.symlinkJoin {
    name = "foot-wrapped";
    paths = [pkgs.foot];
    buildInputs = [pkgs.makeWrapper];
    postBuild = ''
      wrapProgram $out/bin/foot --add-flags "--config=${config}"
    '';
  }
