{ pkgs, username, lib, ... }:
{
  system.stateVersion = "25.11";

  environment.variables.EDITOR = "vim";
  environment.systemPackages = with pkgs; [
    wget
    git
    vim
  ];

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

  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 25;
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

  time = {
    timeZone = lib.mkDefault "Asia/Tokyo";
    hardwareClockInLocalTime = lib.mkDefault true;
  };

  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "es_US.UTF-8";
      LC_IDENTIFICATION = "es_US.UTF-8";
      LC_MEASUREMENT = "es_US.UTF-8";
      LC_MONETUSY = "es_US.UTF-8";
      LC_NAME = "es_US.UTF-8";
      LC_NUMERIC = "es_US.UTF-8";
      LC_PAPER = "es_US.UTF-8";
      LC_TELEPHONE = "es_US.UTF-8";
      LC_TIME = "es_US.UTF-8";
    };
  };
}
