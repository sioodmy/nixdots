{
  modulesPath,
  lib,
  inputs,
  ...
}: {
  imports = [
    inputs.apple-silicon-support.nixosModules.apple-silicon-support

    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  hardware.asahi = {
    enable = true;
    extractPeripheralFirmware = true;
    peripheralFirmwareDirectory = ./firmware;
    withRust = true;
    useExperimentalGPUDriver = true;
    experimentalGPUInstallMode = "replace";
  };

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = lib.mkForce false;
    };
    kernelPatches = [
      {
        name = "edge-config";
        patch = null;
        # derived from
        # https://github.com/AsahiLinux/PKGBUILDs/blob/stable/linux-asahi/config.edge
        extraConfig = ''
          DRM_SIMPLEDRM_BACKLIGHT n
          BACKLIGHT_GPIO n
          DRM_APPLE m
          APPLE_SMC m
          APPLE_SMC_RTKIT m
          APPLE_RTKIT m
          APPLE_MBOX m
          GPIO_MACSMC m
          DRM_VGEM n
          DRM_SCHED y
          DRM_GEM_SHMEM_HELPER y
          DRM_ASAHI m
          SUSPEND y
        '';
      }
    ];

    initrd.availableKernelModules = ["usbhid" "usb_storage" "sd_mod"];
    initrd.kernelModules = ["usbhid" "dm-snapshot"];
  };
}
