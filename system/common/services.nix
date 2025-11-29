{
  pkgs,
  username,
  ...
}: {
  services = {
    # touchpad support
    libinput.enable = true;

    greetd = {
      enable = true;
      settings = {
        terminal.vt = 1;
        default_session = {
          user = username;
          command = "${pkgs.niri}/bin/niri-session";
          # command = "${pkgs.hyprland}/bin/hyprland-session";
        };
      };
    };

    displayManager = {
      autoLogin = {
        enable = true;
        user = username;
      };
    };

    gvfs.enable = true; # Virtual filesystems
    tumbler.enable = true; # Thumbnail support for images
    udisks2.enable = true; # Disk management
    fstrim.enable = true; # SSD trimming

    openssh = {
      enable = true;
      settings = {
        PasswordAuthentication = true;
        PermitRootLogin = "no";
      };
    };

    dbus.implementation = "broker";

    psd = {
      enable = true;
      resyncTimer = "21m";
    };

    # improve preformance
    irqbalance.enable = true;
    ananicy = {
      enable = true;
      package = pkgs.ananicy-cpp;
    };

    # audio
    pulseaudio.enable = false;
    pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse.enable = true;
      jack.enable = true;
      wireplumber.enable = true;
      # lowLatency setting move to game.nix
    };

    blueman.enable = true;

    printing = {
      enable = true;
      drivers = with pkgs; [
        gutenprint
        hplip
        splix
      ];
    };

    geoclue2.enable = true; # Enable geolocation services.

    udev.packages = with pkgs; [
      gnome-settings-daemon
      # platformio # udev rules for platformio
      # openocd # required by paltformio, see https://github.com/NixOS/nixpkgs/issues/224895
      # openfpgaloader
    ];
  };

  security.rtkit.enable = true;

  environment.systemPackages = with pkgs; [
    pulseaudio # provides `pactl`, which is required by some apps(e.g. sonic-pi)
  ];

  # unlock GPG keyring on login
  security.pam.services.greetd.enableGnomeKeyring = true;

  hardware.alsa.enablePersistence = true;
}
