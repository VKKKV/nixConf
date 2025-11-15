{pkgs, ...}:
{
  # Boot configuration
  boot = {
    kernelPackages = pkgs.linuxPackages_zen;
    consoleLogLevel = 3;
    kernelParams = [
      "quiet"
      "systemd.show_status=auto"
      "rd.udev.log_level=3"
      "plymouth.use-simpledrm"
    ];

    plymouth.enable = true;

    tmp = {
      useTmpfs = true;
      cleanOnBoot = true;
    };

    loader = {
      limine = {
        enable = true;
        efiSupport = true;
        style.wallpapers = [
          "/etc/nixos/wallpapers/otherWallpaper/gruvbox/forest_pastel.png"
        ];
        maxGenerations = 10;
        enableEditor = true;
        extraConfig = ''
          /Windows
          protocol: efi
          path: boot():/EFI/Microsoft/Boot/bootmgfw.efi
        '';
      };
      # systemd-boot = {
      #   enable = true;
      #   configurationLimit = 10;
      # };
      efi.canTouchEfiVariables = true;
    };

    supportedFilesystems = [
      "vfat"
      "ext4"
      "ntfs"
    ];
  };
}
