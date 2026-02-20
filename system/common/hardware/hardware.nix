/**
 * system/common/hardware.nix
 * Generic hardware-related configurations shared across all hosts.
 */
{pkgs, ...}: {
  hardware = {
    # Bluetooth configuration with experimental features enabled
    bluetooth = {
      enable = true;
      package = pkgs.bluez5-experimental;
      powerOnBoot = true;
      settings = {
        General = {
          Experimental = true;
          FastConnectable = true;
          JustWorksRepairing = "always";
          Privacy = "device";
        };
      };
    };
  };

  # Enable fwupd for firmware updates
  services.fwupd.enable = true;
}
