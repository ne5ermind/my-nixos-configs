{
  config,
  pkgs,
  lib,
  ...
}:

{
  boot.kernelParams = [
    "amd_pstate=guided"
  ];

  services.power-profiles-daemon.enable = false;
  services.auto-cpufreq.enable = true;

  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
    };

    opengl = {
      enable = true;
    };
  };

  services.fwupd.enable = true;
  services.libinput.enable = true;
  services.fstrim.enable = true;
}
