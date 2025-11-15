{ pkgs, ...}:
{
  hardware = {
    graphics = {
      enable = true;
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
      settings = {
        # make Xbox Series X controller work
        General = {
          Experimental = true;
          FastConnectable = true;
          powerOnBoot = false;
          JustWorksRepairing = "always";
          Privacy = "device";
        };
      };
    };
  };

  services.fwupd.enable = true;
}
