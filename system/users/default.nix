{
  flake,
  pkgs,
  ...
}: {
  users = {
    mutableUsers = false;
    users = {
      root.hashedPasswordFile = "/persist/secrets/root";
      sioodmy = {
        isNormalUser = true;
        homix = true;
        shell = flake.packages.${pkgs.system}.zsh;

        hashedPasswordFile = "/persist/secrets/sioodmy";
        extraGroups = [
          "wheel"
          "systemd-journal"
          "vboxusers"
          "audio"
          "plugdev"
          "wireshark"
          "video"
          "input"
          "lp"
          "networkmanager"
          "power"
          "nix"
          "adbusers"
        ];
        uid = 1000;
      };
    };
  };

  security = {
    sudo = {
      enable = true;
      extraRules = [
        {
          commands =
            builtins.map (command: {
              command = "/run/current-system/sw/bin/${command}";
              options = ["NOPASSWD"];
            })
            ["poweroff" "reboot" "nixos-rebuild" "nix-env" "bandwhich" "systemctl"];
          groups = ["wheel"];
        }
      ];
    };

    pam = {
      u2f = {
        enable = true;
        settings.authfile = builtins.toFile "pamu2cfg" "sioodmy:O38Cg9cbBLEdYUTi8NGDamjrrMsXwB+HGvJeit2AmOa5EyBsdBuSTtwh+/z5TNkv9UgaWBjSGNlJh1vsbhiLPA==,5A49VpssDYhzK98R4Sy8GKFn1gR/4feJT9l+sPMLjgiyweeLJHOqcwn49U4AFT2qb8EBwxQ1Ma8sAHQqtXyN5g==,es256,+presence";
      };
      services = {
        login = {
          enableGnomeKeyring = true;
          fprintAuth = true;
          u2fAuth = true;
        };
        sudo = {
          fprintAuth = true;
          u2fAuth = true;
        };
        hyprlock.fprintAuth = true;
      };

      loginLimits = [
        {
          domain = "@wheel";
          item = "nofile";
          type = "soft";
          value = "524288";
        }
        {
          domain = "@wheel";
          item = "nofile";
          type = "hard";
          value = "1048576";
        }
      ];
    };
  };
}
