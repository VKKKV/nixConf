{ pkgs, ... }:
{
  hardware = {
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

    bluetooth = {
      enable = true;
      package = pkgs.bluez5-experimental;
      powerOnBoot = false;
      settings = {
        # make Xbox Series X controller work
        General = {
          Experimental = true;
          FastConnectable = true;
          JustWorksRepairing = "always";
          Privacy = "device";
        };
      };
    };
  };

  services.fwupd.enable = true;
}
