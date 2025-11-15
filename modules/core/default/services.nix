{ pkgs, username, ...}:
{
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

    # audio
    pulseaudio.enable = false;

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
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
};
hardware.alsa.enablePersistence = true;
}
