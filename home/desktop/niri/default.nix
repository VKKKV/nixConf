{
  lib,
  config,
  pkgs,
  inputs,
  ...
}:
with lib; let
  cfg = config.modules.desktop.niri;
  pointer = config.home.pointerCursor;
in {
  options.modules.desktop.niri = {
    enable = mkEnableOption "Niri window manager";
  };

  config = mkIf cfg.enable {
    home.sessionVariables = {
      CLUTTER_BACKEND = "wayland";
      GDK_BACKEND = "wayland,x11";
      MOZ_ENABLE_WAYLAND = "1";
      NIXOS_OZONE_WL = "1";
      QT_QPA_PLATFORM = "wayland;xcb";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
      SDL_VIDEODRIVER = "wayland";
      WLR_RENDERER = "vulkan";
      XDG_CURRENT_DESKTOP = "niri";
      XDG_SESSION_TYPE = "wayland";
      XMODIFIERS = "@im=fcitx";
    };

    home.packages = with pkgs; [
      seatd
      jaq
    ];

    services = {
      swww.enable = true;
      mako = {
        enable = true;
        settings = {
          border-radius = 8;
          border-size = 2;
          default-timeout = 8000;
          height = 100;
          icons = true;
          ignore-timeout = false;
          layer = "top";
          margin = 10;
          markup = true;
          width = 300;
          "actionable=true".anchor = "top-left";
          actions = true;
          anchor = "top-right";
          "urgency=high".default-timeout = 0;
        };
      };
    };

    programs.niri = {
      enable = true;
      package = pkgs.niri;
      settings = with config.lib.stylix.colors; {
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
          mouse.accel-profile = "flat";
          warp-mouse-to-focus.enable = true;
          workspace-auto-back-and-forth = true;
        };

        outputs."eDP-1" = {
          scale = 1.25;
          mode = {
            width = 3200;
            height = 2000;
            refresh = 90.000;
          };
          position = {x = 0; y = 0;};
          focus-at-startup = true;
        };

        spawn-at-startup = [
          {command = ["/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1"];}
          {command = ["fcitx5 -d"];}
          {command = ["mako"];}
          {command = ["swww-daemon"];}
          {command = ["waybar"];}
          {command = ["wl-paste --type text --watch cliphist store"];}
          {command = ["wl-paste --watch cliphist store"];}
          {command = ["dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=niri & /usr/lib/xdg-desktop-portal-gnome &"];}
        ];

        screenshot-path = "~/Pictures/Screenshots/Screenshot-from-%Y-%m-%d-%H-%M-%S.png";

        overview = {
          workspace-shadow.enable = false;
          backdrop-color = "transparent";
        };
        gestures.hot-corners.enable = true;
        cursor = {
          size = 20;
          theme = "${pointer.name}";
          hide-after-inactive-ms = 10000;
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
            {proportion = 0.33333;}
            {proportion = 0.5;}
            {proportion = 0.66667;}
          ];
          default-column-width.proportion = 0.5;
          gaps = 12;
          shadow = {
            enable = true;
            draw-behind-window = true;
            softness = 20;
            spread = 3;
            offset = {x = -4; y = -4;};
            color = "rgba(0, 0, 0, 0.7)";
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

        window-rules = [
          {
            geometry-corner-radius = {
              bottom-left = 12.0;
              bottom-right = 12.0;
              top-left = 12.0;
              top-right = 12.0;
            };
            clip-to-geometry = true;
            draw-border-with-background = false;
          }
          {
            matches = [{is-floating = true;}];
            shadow.enable = true;
          }
          {
            matches = [
              {app-id = "org.telegram.desktop";}
              {app-id = "app.drey.PaperPlane";}
            ];
            block-out-from = "screencast";
          }
          {
            matches = [
              {app-id = "zen";}
              {app-id = "firefox";}
              {app-id = "chromium-browser";}
              {app-id = "xdg-desktop-portal-gtk";}
            ];
            scroll-factor = 0.5;
          }
          {
            matches = [
              {app-id = "zen";}
              {app-id = "firefox";}
              {app-id = "chromium-browser";}
              {app-id = "edge";}
            ];
            open-maximized = true;
          }
          {
            matches = [
              {app-id = "zen"; title = "Picture-in-Picture";}
              {app-id = "firefox"; title = "Picture-in-Picture";}
            ];
            open-floating = true;
            default-floating-position = {x = 32; y = 32; relative-to = "bottom-right";};
            default-column-width.fixed = 480;
            default-window-height.fixed = 270;
          }
          {
            matches = [
              {app-id = "pavucontrol";}
              {app-id = "pavucontrol-qt";}
              {app-id = "com.saivert.pwvucontrol";}
              {app-id = "dialog";}
              {app-id = "popup";}
              {app-id = "nm-connection-editor";}
              {app-id = "blueman-manager";}
              {app-id = "waypaper";}
              {title = "Confirm";}
              {title = "Warning";}
              {title = "Error";}
            ];
            open-floating = true;
          }
          {
            matches = [{app-id = "fcitx";}];
            open-focused = false;
          }
          {
            clip-to-geometry = true;
            opacity = 0.99;
            draw-border-with-background = false;
          }
        ];

        binds = with config.lib.niri.actions; let
          playerctl = spawn "${pkgs.playerctl}/bin/playerctl";
          terminal = spawn "${pkgs.ghostty}/bin/ghostty";
          launcher = spawn "${pkgs.fuzzel}/bin/fuzzel";
          browser = spawn "${inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default}/bin/zen";
          fileBrowser = spawn "${pkgs.xfce.thunar}/bin/thunar";
          lockScreen = spawn "${pkgs.swaylock}/bin/swaylock";
        in {
          "Mod+T".action = terminal;
          "Mod+F".action = browser;
          "Mod+Space".action = launcher;
          "Mod+L".action = lockScreen;
          "Mod+E".action = fileBrowser;

          "XF86AudioPlay".action = playerctl "play-pause";
          "XF86AudioStop".action = playerctl "pause";
          "XF86AudioPrev".action = playerctl "previous";
          "XF86AudioNext".action = playerctl "next";

          "Print".action.screenshot-screen.write-to-disk = true;
          "Mod+Shift+S".action.screenshot.show-pointer = false;

          "Mod+Return".action = maximize-column;
          "Mod+Q".action = close-window;
          "Mod+S".action = switch-preset-column-width;
          "Mod+W".action = toggle-window-floating;

          "Mod+1".action = set-column-width "25%";
          "Mod+2".action = set-column-width "50%";
          "Mod+3".action = set-column-width "75%";
          "Mod+4".action = set-column-width "100%";

          "Mod+Comma".action = consume-window-into-column;
          "Mod+Period".action = expel-window-from-column;
          "Mod+C".action = center-visible-columns;
          "Mod+Tab".action = switch-focus-between-floating-and-tiling;

          "Mod+Minus".action = set-column-width "-10%";
          "Mod+Plus".action = set-column-width "+10%";
          "Mod+Shift+Minus".action = set-window-height "-10%";
          "Mod+Shift+Plus".action = set-window-height "+10%";

          "Mod+J".action = focus-window-or-workspace-down;
          "Mod+K".action = focus-window-or-workspace-up;
          "Mod+Left".action = focus-column-left;
          "Mod+Right".action = focus-column-right;
          "Mod+Down".action = focus-workspace-down;
          "Mod+Up".action = focus-workspace-up;

          "Mod+Shift+H".action = move-column-left;
          "Mod+Shift+L".action = move-column-right;
          "Mod+Shift+K".action = move-column-to-workspace-up;
          "Mod+Shift+J".action = move-column-to-workspace-down;

          "Mod+Shift+Ctrl+J".action = move-column-to-monitor-down;
          "Mod+Shift+Ctrl+K".action = move-column-to-monitor-up;
        };
      };
    };
  };
}
