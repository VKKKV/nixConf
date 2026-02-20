/**
 * hosts/laptop/default.nix
 * Host-specific configuration for the RedmiBook Pro 15 laptop.
 */
{
  pkgs,
  config,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ../../system/common
    ../../system/hardware/cpu/intel.nix
    ../../system/hardware/gpu/intel.nix
    ../../system/hardware/device/laptop.nix
  ];

  services.keyd = {
    enable = true;
    keyboards = {
      default = {
        ids = ["*"];
        settings = {
          main.capslock = "overload(control,esc)";
        };
      };
    };
  };

  hardware.enableRedistributableFirmware = true;

  boot = {
    loader = {
      limine = {
        extraConfig = ''
          /Windows
          protocol: efi
          path: boot():/EFI/Microsoft/Boot/bootmgfw.efi
        '';
      };
    };
    kernelModules = ["acpi_call"];
    kernelParams = ["mem_sleep_default=deep"];
    extraModulePackages = with config.boot.kernelPackages; [
      acpi_call
    ];
  };
}
