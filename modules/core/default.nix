{ pkgs, username, ... }:
{
  imports = [
    # Core modules
    ./system.nix
    ./network.nix
    ./pipewire.nix
    ./virtualization.nix
    # ./nixpkgs.nix
  ];

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

  # Program configuration
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

    nix-ld = {
      enable = true;
      # libraries = with pkgs; [ ];
    };
  };

  # Security settings
  security = {
    rtkit.enable = true;
    sudo.enable = true;
    pam.services = {
      swaylock = { };
      hyprlock = { };
    };
  };

  # Services configuration
  services = {
    # X Server configuration
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
    # Display Manager
    displayManager = {
      autoLogin = {
        enable = true;
        user = username;
      };
      # defaultSession = "xsession";
    };

    # Core services
    gvfs.enable = true; # Virtual filesystems
    udisks2.enable = true; # Disk management
    fstrim.enable = true; # SSD trimming
    openssh = {
      enable = true;
      settings = {
        PasswordAuthentication = true;
        PermitRootLogin = "no";
        # AllowUsers = [ "arch" ];
      };
    };

    # GNOME services
    gnome = {
      gnome-keyring.enable = true;
      # tracker.enable = true;   # Replaces old tinysparql
    };

    # DBus configuration
    dbus = {
      enable = true;
      packages = [ pkgs.gcr ];
    };
  };

  # Systemd shutdown timeout
  systemd.settings.Manager.DefaultTimeoutStopSec = "10s";

  # Optional environment setup (if needed)
  environment.variables = {
    MOZ_ENABLE_WAYLAND = "1";
    XDG_CURRENT_DESKTOP = "sway";
  };

  # Hardware configuration (example)
  hardware = {
    graphics = {
      enable = true;
      #  driSupport = true;
    };
  };
}
