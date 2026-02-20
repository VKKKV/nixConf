/**
 * system/hardware/gpu/intel.nix
 * Intel GPU specific configurations (Integrated Graphics).
 */
{pkgs, ...}: {
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
      intel-vaapi-driver
      libvdpau-va-gl
    ];
  };
}
