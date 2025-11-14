{ pkgs, username, ... }:
{
  # Boot configuration
  boot = {
    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 10;
      };
      efi.canTouchEfiVariables = true;
    };

    kernelPackages = pkgs.linuxPackages_zen;
    supportedFilesystems = [
      "vfat"
      "ext4"
      "ntfs"
    ];
  };

  programs = {
    dconf.enable = true;
    bash.enable = true;
    zsh.enable = true;
    fish.enable = true;

    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
      pinentryPackage = pkgs.pinentry-gtk2;
    };
  };

  security = {
    rtkit.enable = true;
    sudo.enable = true;
  };

  services = {
    xserver = {
      enable = true;
      xkb = {
        layout = "us";
        options = "caps:escape";
      };
      displayManager = {
        lightdm = {
          enable = true;
          greeters.gtk.cursorTheme = {
            package = pkgs.adwaita-icon-theme;
            size = 10;
          };
        };
      };
    };
    libinput.enable = true;
    displayManager = {
      autoLogin = {
        enable = true;
        user = username;
      };
      # defaultSession = "xsession";
    };

    gvfs.enable = true; # Virtual filesystems
    udisks2.enable = true; # Disk management
    fstrim.enable = true; # SSD trimming
    openssh = {
      enable = true;
      settings = {
        PasswordAuthentication = true;
        PermitRootLogin = "no";
      };
    };

    gnome = {
      gnome-keyring.enable = true;
    };

    dbus = {
      enable = true;
      packages = [ pkgs.gcr ];
    };
  };

    hardware.graphics = {
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
}
