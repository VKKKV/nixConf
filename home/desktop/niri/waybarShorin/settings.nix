{ ... }:
{
  programs.waybar.settings = {
      layer = "top";
      position = "bottom";
      height = 40;
      fixed-center = true;
      reload_style_on_change = true;
      
      modules-left = [
        "niri/workspaces"
        "custom/cava"
        "mpris"
        "custom/screenshot"
        "custom/wfrec"
        "custom/colorpicker"
        "niri/window"
      ];
      
      modules-center = [
        "custom/applauncher"
        "cffi/niri-taskbar"
      ];
      
      modules-right = [
        "custom/updates"
        "tray"
        "group/ddcutil"
        "group/audio"
        "bluetooth"
        "network"
        "idle_inhibitor"
        "power-profiles-daemon"
        "battery"
        "clock"
        "group/powermenu"
      ];
      
      "battery" = {
        interval = 2;
        states = {
          critical = 20;
        };
        format = "{icon}";
        format-charging = "󰂄 {capacity}% ";
        format-icons = ["󰂎" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂂" "󰁹"];
        tooltip-format = " {capacity}% | -{power} | Time:{timeTo}";
      };
      
      "clock" = {
        interval = 60;
        format = "{:%H:%M}";
        tooltip-format = "{:%Y/%m/%d %A}";
        max-length = 25;
        on-click = "gnome-clocks";
        on-click-right = "gnome-calendar";
      };
      
      "clock#date" = {
        format = "󰸗 {:%m-%d}";
        on-click = "gnome-calendar";
        tooltip-format = "{:%Y/%m/%d %A}";
      };
      
      "tray" = {
        icon-size = 24;
        spacing = 7;
      };
      
      "niri/workspaces" = {
        format = "{icon}";
        format-icons = {
          active = "󰜋";
          default = "";
        };
      };
      
      "niri/window" = {
        format = "{}";
        rewrite = {
          "(.*) - Mozilla Firefox" = "🌎 $1";
          "(.*) - zsh" = "> [$1]";
        };
      };
      
      "group/network-bluetooth" = {
        orientation = "inherit";
        drawer = {
          transition-left-to-right = false;
        };
        modules = ["network" "bluetooth"];
      };
      
      "network" = {
        format-disconnected = "{icon}";
        format-wifi = "{icon}";
        format-ethernet = "{icon}";
        format-icons = {
          disconnected = "󰤮";
          wifi = ["󰤯" "󰤟" "󰤢" "󰤥" "󰤨"];
          ethernet = "󰈀";
        };
        tooltip-format-wifi = "{essid} ({signalStrength}%)\n{ifname} : {ipaddr}";
        tooltip-format-ethernet = "{ifname} : {ipaddr} | Click to Open GUI";
        tooltip-format-disconnected = "Disconnected | Click to open GUI";
        on-click = "nm-applet";
        on-click-right = "nm-connection-editor";
      };
      
      "bluetooth" = {
        format-disabled = "󰂲";
        tooltip-format-disabled = "Click to enable";
        format = "󰂯";
        tooltip-format-on = " 󰂯 Click to disable or Right click to open GUI";
        format-connected = "󰂱";
        tooltip-format-connected = "󰂱 {device_alias}Richt click to open GUI";
        on-click = "~/.config/waybar/scripts/toggle-bluetooth.sh";
        on-click-right = "blueberry";
      };
      
      "power-profiles-daemon" = {
        format = "{icon}";
        tooltip-format = "Performance mode:{profile}";
        tooltip = true;
        format-icons = {
          performance = "󱐋";
          balanced = "";
          "power-saver" = "";
        };
      };
      
      "group/tools" = {
        orientation = "inherit";
        drawer = {
          transition-left-to-right = false;
        };
        modules = ["network" "bluetooth"];
      };
      
      "custom/screenshot" = {
        format = "";
        tooltip-format = "Click to easy Screenshot Right Click to power screenshot";
        on-click = "~/.config/waybar/scripts/screenshot.sh";
        on-click-right = "~/.config/waybar/scripts/power-screenshot.sh";
      };
      
      "custom/wfrec" = {
        exec = "~/.config/waybar/scripts/wf-recorder.sh status-json";
        return-type = "json";
        interval = 1;
        signal = 9;
        tooltip = true;
        on-click = "~/.config/waybar/scripts/wf-recorder.sh toggle";
        on-click-right = "~/.config/waybar/scripts/wf-recorder.sh stop";
      };
      
      "group/audio" = {
        orientation = "inherit";
        drawer = {
          transition-left-to-right = false;
        };
        modules = ["pulseaudio" "pulseaudio/slider"];
      };
      
      "pulseaudio" = {
        tooltip-format = "Click to Mute | Right-Click to Mute Mic | Mid-Click to Open Pavucontrol";
        format = "{icon}{volume}% {format_source}";
        format-source = "{volume}%";
        format-source-muted = "";
        format-muted = " {format_source}";
        format-icons = {
          headphone = "";
          bluetooth = "";
          speaker = ["" "" ""];
        };
        on-click = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
        on-click-right = "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle";
        on-click-middle = "pavucontrol --tab=3";
        on-scroll-up = "wpctl set-volume @DEFAULT_AUDIO_SOURCE@ 5%+";
        on-scroll-down = "wpctl set-volume @DEFAULT_AUDIO_SOURCE@ 5%-";
      };
      
      "pulseaudio/slider" = {
        min = 0;
        max = 100;
        orientation = "horizontal";
      };
      
      "mpris" = {
        format = "{player_icon}";
        format-paused = "{status_icon}";
        player-icons = {
          default = "⏸";
        };
        status-icons = {
          paused = "▶";
        };
        toooltip = "{dynamic}";
        enable-tooltip-len-limits = true;
      };
      
      "custom/applauncher" = {
        tooltip-format = "Click to Open Applauncher or Right-Click to Select Wallpaper";
        format = "󰣇";
        on-click = "fuzzel";
        on-click-right = "waypaper";
      };
      
      "group/powermenu" = {
        orientation = "inherit";
        drawer = {
          transition-left-to-right = false;
        };
        modules = [
          "custom/wlogout"
          "custom/reboot"
          "custom/logout"
          "custom/lockscreen"
        ];
      };
      
      "custom/wlogout" = {
        tooltip = false;
        format = "󰐥";
        on-click = "wlogout";
      };
      
      "custom/lockscreen" = {
        tooltip = false;
        format = "";
        on-click = "swaylock || hyprlock";
      };
      
      "custom/reboot" = {
        tooltip = false;
        format = "";
        on-click = "systemctl reboot";
      };
      
      "custom/logout" = {
        format = "󰈆";
        on-click = "niri msg action quit";
        tooltip = false;
      };
      
      "backlight/slider" = {
        min = 5;
        max = 100;
        orientation = "horizontal";
      };
      
      "backlight" = {
        tooltip = false;
        format = "{icon}";
        format-icons = ["" "" "" "" "" "" "" "" ""];
      };
      
      "group/ddcutil" = {
        orientation = "inherit";
        drawer = {
          transition-left-to-right = false;
        };
        modules = [
          "custom/ddcutil-day"
          "backlight/slider"
          "backlight"
          "custom/separator#1"
          "custom/ddcutil-sleep"
          "custom/ddcutil-night"
        ];
      };
      
      "custom/ddcutil-day" = {
        tooltip-format = "Ex.Monitor 100% brightness";
        format = "󰃠";
        on-click = "ddcutil --display 1 setvcp 10 100 ";
      };
      
      "custom/ddcutil-night" = {
        tooltip-format = "Ex.Monitor 65% brightness";
        format = "󰃟";
        on-click = "ddcutil --display 1 setvcp 10 65 ";
      };
      
      "custom/ddcutil-sleep" = {
        tooltip-format = "Ex.Monitor 5% brightness";
        format = "󰃞";
        on-click = "ddcutil --display 1 setvcp 10 5 ";
      };
      
      "custom/swaync" = {
        tooltip = false;
        format = "{icon}";
        format-icons = {
          notification = "<span foreground='red'><sup></sup></span>";
          none = "";
          "dnd-notification" = "<span foreground='red'><sup></sup></span>";
          "dnd-none" = "";
          "inhibited-notification" = "<span foreground='red'><sup></sup></span>";
          "inhibited-none" = "";
          "dnd-inhibited-notification" = "<span foreground='red'><sup></sup></span>";
          "dnd-inhibited-none" = "";
        };
        return-type = "json";
        exec-if = "which swaync-client";
        exec = "swaync-client -swb";
        on-click = "swaync-client -t -sw";
        on-click-right = "swaync-client -d -sw";
        escape = true;
      };
      
      "custom/mako" = {
        format = "";
        on-click = "makoctl restore";
      };
      
      "custom/settings" = {
        format = "";
        on-click = "env XDG_CURRENT_DESKTOP=GNOME gnome-control-center";
        tooltip-format = "Open control center";
      };
      
      "custom/colorpicker" = {
        tooltip = false;
        format = "󱏜";
        on-click = "hyprpicker | wl-copy";
      };
      
      "custom/cava" = {
        tooltip = false;
        format = "{}";
        exec = "~/.config/waybar/scripts/cava.sh";
      };
      
      "idle_inhibitor" = {
        format = "{icon}";
        format-icons = {
          activated = "";
          deactivated = "";
        };
        "tooltip-format-activated" = "idle Enabled";
        "tooltip-format-deactivated" = "idle Disabled";
      };
      
      "custom/separator#1" = {
        format = "󱋱";
        tooltip = false;
      };
      
      "custom/separator#2" = {
        format = "";
        tooltip = false;
      };
      
      "custom/updates" = {
        format = "{}{icon}";
        return-type = "json";
        format-icons = {
          "has-updates" = "";
          updated = "";
        };
        exec-if = "which waybar-module-pacman-updates";
        exec = "waybar-module-pacman-updates --no-zero-output";
        on-click = "ghostty -e yay";
      };
      
      "privacy" = {
        "icon-spacing" = 10;
        "icon-size" = 18;
        "transition-duration" = 250;
        modules = [
          {
            type = "screenshare";
            tooltip = true;
            "tooltip-icon-size" = 24;
          }
        ];
      };
      
      "cffi/niri-taskbar" = {
        "module_path" = "/usr/lib/waybar/libniri_taskbar.so";
        apps = {
          signal = [
            {
              match = "\\([0-9]+\\)$";
              class = "unread";
            }
          ];
        };
      };
      
      "ext/workspaces" = {
        format = "{icon}";
        "ignore-hidden" = true;
        on-click = "activate";
        "on-click-right" = "deactivate";
        "sort-by-id" = true;
      };
      
      "dwl/window" = {
        format = "[{layout}]{title}";
      };
    };
}