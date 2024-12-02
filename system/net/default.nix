{
  lib,
  config,
  ...
}: let
  inherit (lib) mkIf;
in {
  networking = {
    nameservers = ["127.0.0.1" "::1"];
    dhcpcd.extraConfig = "nohook resolv.conf";
    networkmanager = {
      enable = true;
      unmanaged = ["docker0" "rndis0"];
      dns = "none";
      wifi = {
        macAddress = mkIf (! config.hardware.asahi.enable) "random";
        powersave = true;
      };
    };
    firewall = {
      enable = true;
      allowPing = false;
      logReversePathDrops = true;
    };
  };

  # encrypted dns
  services.dnscrypt-proxy2 = {
    enable = true;
    settings = {
      require_dnssec = true;

      sources.public-resolvers = {
        urls = [
          "https://raw.githubusercontent.com/DNSCrypt/dnscrypt-resolvers/master/v3/public-resolvers.md"
          "https://download.dnscrypt.info/resolvers-list/v3/public-resolvers.md"
        ];
        cache_file = "/var/lib/dnscrypt-proxy2/public-resolvers.md";
        minisign_key = "RWQf6LRCGA9i53mlYecO4IzT51TGPpvWucNSCh1CBM0QTaLn73Y7GFO3";
      };
    };
  };

  # slows down boot time
  systemd.services.NetworkManager-wait-online.enable = false;
}
