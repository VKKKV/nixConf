/**
 * system/hardware/cpu/intel.nix
 * Intel CPU specific configurations.
 */
{
  pkgs,
  config,
  ...
}: {
  boot = {
    kernelModules = [
      "kvm-intel"
    ];
    extraModprobeConfig = "options kvm_intel nested=1";
  };

  hardware.cpu.intel.updateMicrocode = true;

  services.thermald.enable = true;

  powerManagement.powertop.enable = true;
}
