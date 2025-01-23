{pkgs, ...}: {
  environment.systemPackages = [pkgs.nvfetcher];
  nix = {
    # gc kills ssds
    gc.automatic = false;

    # nix but cooler
    package = pkgs.lix;

    # Make builds run with low priority so my system stays responsive
    daemonCPUSchedPolicy = "idle";
    daemonIOSchedClass = "idle";

    settings = {
      flake-registry = "/etc/nix/registry.json";
      auto-optimise-store = true;
      # use binary cache, its not gentoo
      builders-use-substitutes = true;
      # allow sudo users to mark the following values as trusted
      allowed-users = ["@wheel"];
      trusted-users = ["@wheel"];
      commit-lockfile-summary = "chore: Update flake.lock";
      accept-flake-config = true;
      keep-derivations = true;
      keep-outputs = true;
      warn-dirty = false;

      sandbox = true;
      max-jobs = "auto";
      # continue building derivations if one fails
      keep-going = true;
      log-lines = 20;
      extra-experimental-features = ["flakes" "nix-command" "recursive-nix" "ca-derivations"];

      # use binary cache, its not gentoo
      substituters = [
        "https://cache.nixos.org"
      ];

      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      ];
    };
  };

  programs.nix-ld.enable = true;
  programs.nh = {
    enable = true;
    flake = "/home/sioodmy/dev/dotfiles";
  };

  # WE DONT WANT TO BUILD STUFF ON TMPFS
  # ITS NOT A GOOD IDEA
  systemd.services.nix-daemon = {
    environment.TMPDIR = "/var/tmp";
  };

  # this makes rebuilds little faster
  system.switch = {
    enable = false;
    enableNg = true;
  };

  nixpkgs = {
    config = {
      # Wolność kocham i rozumiem
      # Wolności oddać nie umiem
      # <3333
      allowUnfree = false;
      allowBroken = true;
    };
  };
}
