/**
 * system/common/services.nix
 * General system services configuration.
 * Includes greetd, display manager, audio (Pipewire), and hardware services.
 */
{
  pkgs,
  username,
  ...
}: {
  services = {
    # Greetd: A minimalist login manager
    greetd = let
      session = {
        command = "${pkgs.hyprland}/bin/hyprland";
        user = username;
      };
    in {
      enable = true;
      settings = {
        terminal.vt = 1;
        default_session = session;
        initial_session = session;
      };
    };

    # Display Manager with auto-login support
    displayManager = {
      autoLogin = {
        enable = true;
        user = username;
      };
    };

    libinput.enable = true; # Touchpad/Mouse support
    gvfs.enable = true; # Virtual filesystem support
    tumbler.enable = true; # Thumbnail generation
    udisks2.enable = true; # Disk mounting and management
    fstrim.enable = true; # Periodic SSD TRIM

    # OpenSSH daemon configuration
    openssh = {
      enable = true;
      settings = {
        PasswordAuthentication = true;
        PermitRootLogin = "no";
      };
    };

    # Modern DBus implementation
    dbus.implementation = "broker";

    # Profile-sync-daemon for browser performance
    psd = {
      enable = true;
      resyncTimer = "21m";
    };

    # Performance & Responsiveness tweaks
    irqbalance.enable = true;
    ananicy = {
      enable = true;
      package = pkgs.ananicy-cpp;
    };

    # Audio configuration using Pipewire
    pulseaudio.enable = false; # Use Pipewire instead of legacy PulseAudio
    pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse.enable = true;
      jack.enable = true;
      wireplumber.enable = true;
    };

    # Bluetooth manager
    blueman.enable = true;

    # Printing services (CUPS)
    printing = {
      enable = true;
      drivers = with pkgs; [
        gutenprint
        hplip
        splix
      ];
    };

    geoclue2.enable = true; # Geolocation services
  };

  # Real-time kit for audio performance
  security.rtkit.enable = true;

  # Additional system-wide audio utilities
  environment.systemPackages = with pkgs; [
    pulseaudio # Provides `pactl` for compatibility
  ];

  # Unlock GPG/Keyring on login
  security.pam.services.greetd.enableGnomeKeyring = true;

  # Hardware state persistence
  hardware.alsa.enablePersistence = true;
}
