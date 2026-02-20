/**
 * system/common/hardware.nix
 * Common hardware-related configurations.
 * Includes graphics drivers, Bluetooth settings, and firmware management.
 */
{pkgs, ...}: {
  hardware = {
    # Graphics configuration for both 64-bit and 32-bit applications
    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
        libva
        libva-vdpau-driver
        libvdpau-va-gl
        mesa
      ];
      extraPackages32 = with pkgs.pkgsi686Linux; [
        libva-vdpau-driver
        libvdpau-va-gl
      ];
    };

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
