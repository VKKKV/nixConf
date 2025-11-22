{
  config,
  pkgs,
  ...
}:
let
  pointer = config.home.pointerCursor;
in
{
  programs.niri = with config.lib.stylix.colors; {
    enable = true;
    package = pkgs.niri;
    settings = {
      environment = {
        CLUTTER_BACKEND = "wayland";
        DISPLAY = null;
        GDK_BACKEND = "wayland,x11";
        MOZ_ENABLE_WAYLAND = "1";
        NIXOS_OZONE_WL = "1";
        QT_QPA_PLATFORM = "wayland;xcb";
        QT_QPA_PLATFORMTHEME = "qt6ct";
        QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
        SDL_VIDEODRIVER = "wayland";
        WLR_RENDERER = "vulkan";
        XDG_CURRENT_DESKTOP = "niri";
        XDG_SESSION_TYPE = "wayland";
        XMODIFIERS = "@im=fcitx";
      };

      input = {
        keyboard.xkb.layout = "us";
        touchpad = {
          click-method = "button-areas";
          dwt = true;
          dwtp = true;
          natural-scroll = true;
          scroll-method = "two-finger";
          tap = true;
          tap-button-map = "left-right-middle";
          middle-emulation = true;
          accel-profile = "flat";
        };
        focus-follows-mouse = {
          enable = true;
          max-scroll-amount = "90%";
        };
        mouse = {
          accel-profile = "flat";
        };
        warp-mouse-to-focus.enable = true;
        workspace-auto-back-and-forth = true;
      };

      outputs = {
        "eDP-1" = {
          scale = 1.5;
          mode = {
            width = 3200;
            height = 2000;
            refresh = 90.000;
          };
          position = {
            x = 0;
            y = 0;
          };
          focus-at-startup = true;
        };
      };

      spawn-at-startup = [
        # { command = [ "/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1" ]; }
        { command = [ "clipse --listen" ]; }
        { command = [ "fcitx5 -d" ]; }
        { command = [ "mako" ]; }
        { command = [ "swww-daemon" ]; }
        { command = [ "waybar" ]; }
        { command = [ "wl-paste --type text --watch cliphist store" ]; }
        { command = [ "wl-paste --watch cliphist store" ]; }
        {
          command = [
            "qs"
            "-c"
            "dms"
          ];
        }
        {
          command = [
            "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=niri & /usr/lib/xdg-desktop-portal-gnome &"
          ];
        }
      ];

      screenshot-path = "~/Pictures/Screenshots/Screenshot-from-%Y-%m-%d-%H-%M-%S.png";

      overview = {
        workspace-shadow.enable = false;
        backdrop-color = "transparent";
      };
      gestures = {
        hot-corners.enable = true;
      };
      cursor = {
        size = 20;
        theme = "${pointer.name}";
      };

      layout = {
        focus-ring = {
          enable = true;
          width = 3;
          active.color = "#${base0B}";
        };

        border = {
          enable = false;
          width = 2;
          active.color = "#${base0B}";
          inactive.color = "#${base0F}";
        };

        preset-column-widths = [
          { proportion = 0.33333; }
          { proportion = 0.5; }
          { proportion = 0.66667; }

          # { proportion = 0.25; }
          # { proportion = 0.5; }
          # { proportion = 0.75; }
          # { proportion = 1.0; }
        ];
        default-column-width = {
          proportion = 0.5;
        };

        # gaps = 6;
        gaps = 12;

        shadow = {
          enable = true;
          draw-behind-window = true;
          softness = 20;
          spread = 3;
          offset = {
            x = -4;
            y = -4;
          };
          color = "rgba(0, 0, 0, 0.7)";
        };

        struts = {
          left = 0;
          right = 0;
          top = 0;
          bottom = 0;
        };

        center-focused-column = "on-overflow";

        tab-indicator = {
          hide-when-single-tab = true;
          place-within-column = true;
          position = "left";
          corner-radius = 20.0;
          gap = -12.0;
          gaps-between-tabs = 10.0;
          width = 4.0;
          length.total-proportion = 0.1;
        };
      };
      prefer-no-csd = true;
      hotkey-overlay.skip-at-startup = true;
    };
  };
}
