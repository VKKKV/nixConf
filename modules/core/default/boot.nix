{pkgs, ...}:
{
  # Boot configuration
  boot = {
    loader = {
      limine = {
        enable = true;
        efiSupport = true;
        style.wallpapers = ../../../wallpapers/lain.jpeg;
        maxGenerations = 10;
      };
      # systemd-boot = {
      #   enable = true;
      #   configurationLimit = 10;
      # };
      efi.canTouchEfiVariables = true;
    };

    kernelPackages = pkgs.linuxPackages_zen;
    supportedFilesystems = [
      "vfat"
      "ext4"
      "ntfs"
    ];
  };
}
