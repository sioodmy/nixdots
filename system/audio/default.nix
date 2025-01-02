{pkgs, ...}: {
  services.pipewire = {
    enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
    wireplumber = {
      enable = true;
      extraConfig = {
        "10-bluez" = {
          "monitor.bluez.properties" = {
            "bluez5.enable-sbc-xq" = true;
            "bluez5.enable-msbc" = true;
            "bluez5.enable-hw-volume" = true;
            "bluez5.codecs" = ["sbc" "sbc_xq" "aac" "ldac" "aptx" "aptx_hd"];
          };
        };
      };
    };
    pulse.enable = true;
    jack.enable = true;
  };

  hardware = {
    pulseaudio.support32Bit = true;

    bluetooth = {
      enable = true;
      powerOnBoot = false;
      package = pkgs.bluez5-experimental;
    };
  };
}
