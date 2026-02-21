{
  lib,
  config,
  ...
}:
with lib; {
  config = mkIf config.modules.desktop.enable {
    programs.waybar = {
      enable = true;
      settings.mainBar = {
        # Basic layout settings
        layer = "top";
        position = "bottom";
        mod = "dock";
        height = 28;
        exclusive = false;
        fixed-center = true;
        passthrough = false;
        gtk-layer-shell = true;
        reload_style_on_change = true;

        # Margin settings
        margin-top = 0;
        margin-bottom = 0;
        margin-left = 0;

        # Module layout
        modules-center = [
          "custom/left_div#4"
          "clock"
          "pulseaudio"
          "tray"
          "custom/right_div#4"
        ];

        # Custom separator modules
        "custom/left_div#4" = {
          format = "";
          tooltip = false;
        };

        "custom/right_div#4" = {
          format = "";
          tooltip = false;
        };

        # Module detailed configuration
        tray = {
          spacing = 10;
          tooltip = false;
        };

        clock = {
          format = "{:%a, %d %I:%M}";
          tooltip = true;
        };

        pulseaudio = {
          scroll-step = 5;
          max-volume = 150;
          format = "vol{volume}%";
          format-muted = "MUTED";
          format-bluetooth = "vol{volume}%";
          nospacing = 1;
          on-click = "pwvucontrol";
          tooltip = false;
        };
        power-profiles-daemon = {
          format = "{icon}";
          tooltip-format = "Current performance mode: {profile}\n---\nLeft click: Switch performance mode";
          tooltip = true;
          format-icons = {
            performance = "󱐋";
            balanced = "";
            power-saver = "";
          };
        };
      };

      style = ''
        /* Gruvbox Dark Colors */
        @define-color on_secondary #282828;
        @define-color background-light #3c3836;
        @define-color secondary #ebdbb2;
        @define-color black #32302f;
        @define-color red #cc241d;
        @define-color green #98971a;
        @define-color yellow #d79921;
        @define-color blue #458588;
        @define-color magenta #b16286;
        @define-color cyan #689d6a;
        @define-color white #ebdbb2;
        @define-color orange #d65d0e;

        * {
            border: none;
            border-radius: 0;
            font-family: "JetBrainsMono Nerd Font Propo";
            font-size: 18px;
            opacity: 1;
        }

        window#waybar {
            background: transparent;
            color: @on_surface;
        }

        /* Center First Level */
        #custom-applauncher {
            font-size: 25px;
            padding: 0px 7px;
            margin: 0px;
            background-color: @primary;
            color: @on_primary;

        }

        #custom-left_div.11,
        #custom-right_div.11 {
            margin: 0px;
            padding: 0px;
            font-size: 25px;


        }

        #custom-left_div.11 {
            background-color: @tertiary;
            color: @surface_container
        }

        #custom-right_div.11 {

            background-color: @secondary;
            color: @surface_container;
        }

        #custom-left_div.1,
        #custom-right_div.1 {
            padding: 0px;
            margin: 0px;
            font-size: 25px;
        }

        #custom-left_div.1 {
            background-color: @surface_container;
            color: @primary;
        }

        #custom-right_div.1 {

            background-color: @surface_container;
            color: @primary;

        }

        #custom-left_inv.1,
        #custom-right_inv.1 {
            padding: 0px;
            margin: 0px;
            font-size: 25px;
        }

        #custom-left_inv.1 {
            background-color: @surface_container;
            color: @tertiary;
        }

        #custom-right_inv.1 {
            background-color: @surface_container;
            color: @secondary;
        }

        /* Center Left Second Level */
        #power-profiles-daemon,
        #custom-colorpicker,
        #idle_inhibitor {
            padding: 0px 7px;
        }


        #power-profiles-daemon {
            background-color: @tertiary;
            color: @on_secondary;
        }

        #power-profiles-daemon.performance {
            color: @on_error;
            font-size: 23px;
        }

        #power-profiles-daemon.balanced {
            color: @on_tertiary;
        }

        #power-profiles-daemon.power-saver {
            color: #1aa052;

        }

        #custom-colorpicker {
            background-color: @tertiary;
            color: @on_tertiary;

        }

        #idle_inhibitor {
            background-color: @tertiary;
            color: @on_tertiary;

        }

        #custom-left_div.2 {
            background-color: @secondary_container;
            color: @tertiary;
            padding: 0px 0px;
            font-size: 25px;
        }

        /* Center Right Second Level */

        #clock {
            padding: 0px 7px;
        }

        #clock {
            background-color: @on_secondary;
            color: @secondary;

        }

        #custom-right_div.2 {
            background-color: @secondary_container;
            color: @secondary;
            padding: 0px 0px;
            font-size: 25px;
        }


        /* Center Right Third Level */

        #clock.date {
            padding: 0px 7px;
        }

        #custom-datelogo,
        #clock.date {
            background-color: @secondary_container;
            color: @on_secondary_container;
        }

        #custom-right_div.3 {
            background-color: @on_secondary;
            color: @secondary_container;
            padding: 0px;
            font-size: 25px;
        }

        /* Center Right Fourth Level */
        #battery {
            background-color: @on_secondary;
            color: @on_surface;
            padding: 0px 7px;
        }

        #battery.critical:not(.charging) {
            background-color: @error;
            color: @on_error;
            animation-name: blink;
            animation-duration: 0.5s;
            animation-timing-function: steps(12);
            animation-iteration-count: infinite;
            animation-direction: alternate;
            padding: 0px 7px;
        }

        #custom-right_div.4 {
            /* background-color: @surface_container_high; */
            color: @on_secondary;
            padding: 0px;
            font-size: 25px;
        }

        /* Center Left Third Level */

        #bluetooth {
            padding: 0px 7px;
            font-size: 20px;
        }

        #network {
            padding: 0px 7px;
            font-size: 22px;

        }

        #custom-settings {
            padding: 0px 7px;
            font-size: 19px;
        }

        #custom-screenshot {
            padding: 0 7px;
            font-size: 22px;
        }

        #bluetooth,
        #network,
        #custom-settings,
        #custom-screenshot {
            background-color: @secondary_container;
            color: @on_secondary_container;
        }

        #custom-left_div.3 {
            background-color: @on_secondary;
            color: @secondary_container;
            padding: 0px;
            font-size: 25px;
        }


        /* Center Left Fourth Level */


        #tray {
            padding: 0px 7px 0px 7px;
            font-size: 20px;
            background-color: @on_secondary;
        }

        #custom-left_div.4 {
            /* background-color: @surface_container_high; */
            color: @on_secondary;
            padding: 0px;
            font-size: 25px;
        }

        /* Rightmost Powermenu */
        #custom-wlogout {
            padding: 0px 15px 0px 10px;
            font-size: 25px;
            background-color: @surface;
        }

        #custom-wlogout,
        #custom-reboot,
        #custom-lockscreen,
        #custom-logout {
            background-color: @surface_container_high;
            color: @error;
            padding: 0px 10px;
        }

        #custom-left_div.5 {
            background-color: @surface;
            color: @surface_container_high;
            padding: 0px;
            font-size: 25px;
        }

        /* Rightmost Second Level */

        #custom-swaync {
            background-color: @surface_container_high;
            color: @on_surface_container;
            padding: 0px 15px;
        }

        #custom-mako {
            background-color: @surface_container_high;
            color: @on_surface_container;
            padding: 0px 15px;
        }

        #custom-left_div.6 {
            background-color: @surface;
            color: @surface_container_high;
            padding: 0px;
            font-size: 25px;
        }

        /* Rightmost Third Level */
        #custom-cava {
            background-color: @surface;
            color: @primary;
            padding: 0px 10px;
        }

        #mpris {
            background-color: @surface;
            color: @primary;

            padding: 0px 10px 0px 0px;
        }

        #custom-left_div.8 {
            background-color: @surface_container_high;
            color: @surface;
            font-size: 25px;
            padding: 0px;
        }

        #custom-updates {
            border-radius: 0px;
            padding: 0px 5px 0px 0px;
            background-color: @surface_container_high;
            color: @error;

        }


        #pulseaudio {
            padding: 0px 0px 0px 5px;
        }

        #pulseaudio-slider {
            padding: 0px 0px 0px 10px;
            margin: 0px;
        }

        #privacy {
            padding: 0px 7px;
        }

        #pulseaudio-slider,
        #pulseaudio {
            background-color: @on_secondary;
            color: @secondary;
        }

        #pulseaudio-slider slider {
            min-height: 0px;
            min-width: 0px;
            opacity: 0;
            background-image: none;
            box-shadow: none;
            background: none;
        }

        #pulseaudio-slider trough {
            min-height: 10px;
            min-width: 80px;
            border-radius: 5px;
            background-color: @background;
        }

        #pulseaudio-slider highlight {
            min-width: 0px;
            border-radius: 5px;
            background-color: @inverse_primary;
        }

        #privacy {
            background-color: @surface_container_high;
            color: @tertiary;
        }

        #custom-ddcutil-day,
        #custom-ddcutil-night,
        #custom-ddcutil-sleep,
        #custom-separator.1 {
            background-color: @surface_container_high;
            color: @secondary;
            padding: 0px 5px;
        }

        #backlight {
            background-color: @surface_container_high;
            color: @secondary;
            padding: 0px 5px 0px 0px;
        }

        #backlight-slider {
            background-color: @surface_container_high;
            padding: 0px 5px 0px 0px;
        }

        #backlight-slider slider {
            min-height: 0px;
            min-width: 0px;
            opacity: 0;
            background-image: none;
            border: none;
            box-shadow: none;
            background: none;
        }

        #backlight-slider trough {
            min-height: 10px;
            min-width: 80px;
            border-radius: 5px;
            opacity: 0;
            background-color: @background;
        }

        #backlight-slider highlight {
            min-width: 10px;
            border-radius: 5px;
            background-color: @inverse_primary;
        }

        #custom-left_div.7 {
            /* background-color: @surface_container_high; */
            color: @surface_container_high;
            font-size: 25px;
            padding: 0px;
        }


        /* Workspaces */
        #workspaces button {
            padding: 0px 10px;
            background: @surface_container;
            color: @tertiary;
        }

        /* #workspaces label {
            font-size: 22;
        } */

        #workspaces button:hover {
            background: @on_tertiary;
        }

        #workspaces button.focused:hover {
            background: @surface_bright;
        }

        #workspaces button.focused {
            background: @surface_container;
            color: @tertiary;

        }

        #custom-right_div.5 {
            background: @surface_bright;
            color: @surface_container;
            font-size: 25px;
            padding: 0px;
        }

        /* waybar niri taskbar */
        .niri-taskbar {
            background: @surface_bright;
            padding: 0 0 0 5px;
        }

        .niri-taskbar button:hover {
            background: @surface_container_high;
        }

        .niri-taskbar button.focused {
            background: @surface_container_high;
        }

        /* Window Name */
        #window {
            padding: 0px 10px;
            background-color: @surface_bright;
            color: @on_surface;
        }

        #window label {
            font-size: 16px;
        }

        window#waybar.empty #window {
            background-color: @surface_bright;
        }

        #custom-right_div.6 {
            color: @surface_bright;
            font-size: 25px;
            padding: 0px;
        }

        /* Tooltip */
        tooltip {
            background: @secondary_container;
            border: 3px solid @outline;
            opacity: 0.8;
        }

        tooltip label {
            color: white;
            font-size: 16px;
        }
      '';
    };
  };
}
