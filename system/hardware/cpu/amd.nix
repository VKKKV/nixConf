/**
 * system/hardware/cpu/amd.nix
 * AMD CPU specific configurations.
 */
{
  pkgs,
  config,
  ...
}: {
  boot = {
    kernelModules = [
      "kvm-amd"
    ];
    extraModprobeConfig = "options kvm_amd nested=1";
  };

  hardware.cpu.amd.updateMicrocode = true;
}
