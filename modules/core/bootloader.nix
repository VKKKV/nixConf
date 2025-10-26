{ pkgs, ... }:
{
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      systemd-boot.configurationLimit = 10;
      # grub.configurationLimit=10;
    };

    kernelPackages = pkgs.linuxPackages_zen;
    supportedFilesystems = [
      "fat32"
      "ext4"
      "ntfs"
    ];
  };
}
