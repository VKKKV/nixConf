{ pkgs, username, ...}:
{
  services = {

    libinput.enable = true;

    # login manager
    greetd = let
      session = {
        command = "${pkgs.niri}/bin/niri-session";
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
    displayManager = {
      autoLogin = {
        enable = true;
        user = username;
      };
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
    # low latency
    extraConfig = {
      pipewire."92-low-latency" = {
        "context.properties" = {
          "default.clock.rate" = 48000;
          "default.clock.quantum" = 32;
          "default.clock.min-quantum" = 32;
          "default.clock.max-quantum" = 32;
        };
      };
      pipewire-pulse."92-low-latency" = {
        context.modules = [
          {
            name = "libpipewire-module-protocol-pulse";
            args = {
              pulse.min.req = "32/48000";
              pulse.default.req = "32/48000";
              pulse.max.req = "32/48000";
              pulse.min.quantum = "32/48000";
              pulse.max.quantum = "32/48000";
            };
          }
        ];
        stream.properties = {
          node.latency = "32/48000";
          resample.quality = 1;
        };
      };
    };
  };

  printing = {
    enable = true;
    drivers = with pkgs; [ gutenprint hplip splix ];
  };
};
    # unlock GPG keyring on login
    security.pam.services.greetd.enableGnomeKeyring = true;

  hardware.alsa.enablePersistence = true;
}
