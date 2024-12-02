{pkgs, ...}: let
  inherit (pkgs.lib.meta) getExe' getExe;

  mkTofi = {
    name,
    script,
    makeDesktop ? false,
  }: let
    script-name = "tofi-${name}";
    script-out = pkgs.writeShellScriptBin "${script-name}" script;
  in
    if makeDesktop
    then
      pkgs.symlinkJoin {
        inherit name;
        paths = [
          (pkgs.makeDesktopItem {
            name = script-name;
            desktopName = script-name;
            exec = "${getExe script-out}";
          })
          script-out
        ];
      }
    else script-out;
in [
  (
    mkTofi {
      name = "calc";
      script = ''
        #!/bin/sh
        set -e

        INPUT=$(echo | tofi --require-match false --prompt-text "calc: " --height 80)
        OUTPUT="$(echo "scale=2; $INPUT" | ${getExe' pkgs.bc "bc"} -s)"

        notify-send "$OUTPUT" "$INPUT"
      '';
      makeDesktop = true;
    }
  )

  (
    mkTofi {
      name = "confirm";
      script = ''
        #!/bin/sh

        # usage: tofi-confirm [PROMPT TEXT] [SHELL COMMAND TO EXECUTE]
        [[ "$(printf 'No\nYes' | tofi --prompt-text "$1")" == "Yes" ]] && exec sh -c "$2"
      '';
    }
  )

  (
    mkTofi {
      name = "power";
      script = ''
        #!/bin/sh

        menu="Cancel\nShutdown\nSuspend\nHibernate\nReboot"

        pick=$(echo -e "$menu" | tofi)

        case "$pick" in
            "Cancel") exit ;;
            "Shutdown") sudo poweroff ;;
            "Suspend") systemctl suspend ;;
            "Hibernate") sudo systemctl hibernate ;;
            "Reboot") sudo reboot ;;
        esac

      '';
      makeDesktop = true;
    }
  )

  (
    mkTofi {
      name = "emoji";
      script = ''
        #!/bin/sh
        cat ${./emojis} | tofi | awk '{print $1}' | tr -d '\n' | tee >(${getExe' pkgs.wl-clipboard "wl-copy"}) >(xargs -I % notify-send "% Emoji" "Emoji copied to clipboard")
      '';
      makeDesktop = true;
    }
  )
]
