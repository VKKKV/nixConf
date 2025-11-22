{ ... }:
{
  programs.waybar.style = ''
    * {
        border: none;
        border-radius: 5px;
        min-height: 0;
    }

    window#waybar {
        border-radius: 0px;
    }

    tooltip {
        border: 2px solid;
        opacity: 1;
    }

    tooltip label {
        font-size: 16px;
    }

    #workspaces {
        padding: 0px 5px;
        margin: 5px;
    }

    #workspaces button {
        padding: 0px 10px;
    }

    #workspaces button:hover {
    }

    #workspaces button.active {
    }

    #mpris,
    #custom-cava {
    }

    #custom-cava {
        padding: 0px 5px 0px 10px;
        margin: 5px 0px 5px 5px;
    }

    #mpris {
        padding: 0px 5px;
        margin: 5px 0px 5px 5px;
    }

    #custom-screenshot,
    #custom-wfrec,
    #custom-colorpicker {
    }

    #custom-screenshot,
    #custom-wfrec,
    #custom-colorpicker {
        padding: 0px 5px;
        margin: 5px 0px 5px 0px;
        font-size: 20px;
    }

    #custom-screenshot {
        padding: 0px 5px 0px 10px;
        margin: 5px 0px 5px 10px;
        border-radius: 5px 0px 0px 5px;
    }

    #custom-wfrec {
        border-radius: 0px;
    }

    #custom-colorpicker {
        padding: 0px 10px 0px 5px;
        margin: 5px 5px 5px 0px;
        border-radius: 0px 5px 5px 0px;
    }

    #window {
        padding: 0px 10px;
        margin: 5px;
    }

    #window label {
        font-size: 16px;
    }

    #custom-applauncher {
        font-size: 25px;
        padding: 0px 10px;
        margin: 5px;
    }

    #custom-separator.2 {
        font-size: 28px;
        padding: 0px 5px;
    }

    /* waybar niri taskbar */
    .niri-taskbar {
        background: none;
        padding: 0px;
        margin: 4px;
    }

    .niri-taskbar button.urgent {
        animation-name: blink;
        animation-duration: 0.5s;
        animation-timing-function: steps(12);
        animation-iteration-count: infinite;
        animation-direction: alternate;
    }

    #custom-updates {
        padding: 0px 10px;
        margin: 5px;
    }

    #tray {
        padding: 0px 10px;
        margin: 5px;
    }

    #custom-ddcutil-day,
    #custom-ddcutil-night,
    #custom-ddcutil-sleep,
    #custom-separator.1,

    #custom-ddcutil-day,
    #custom-ddcutil-night,
    #custom-ddcutil-sleep,
    #custom-separator.1 {
        font-size: 20px;
        padding: 0px 5px;
    }

    #custom-ddcutil-day {
        padding: 0px 10px;
        margin: 5px 5px 5px 5px;
        border-radius: 5px 5px 5px 5px;
    }

    #custom-ddcutil-night {
        border-radius: 0px 5px 5px 0px;
        margin: 8px 2px 8px 0px;
    }

    #custom-ddcutil-sleep,
    #custom-separator.1 {
        border-radius: 0px;
        margin: 8px 0px;
    }

    #backlight {
        font-size: 22px;
        padding: 0px 5px 0px 0px;
        margin: 8px 0px;
        border-radius: 0px;
    }

    #backlight-slider {
        padding: 0px 7px 0px 10px;
        margin: 8px 0px 8px 10px;
        border-radius: 5px 0px 0px 5px;
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
    }

    #backlight-slider highlight {
        min-width: 10px;
        border-radius: 5px;
    }

    #pulseaudio {
        padding: 0px 10px;
        margin: 5px;
    }

    #pulseaudio-slider {
        padding: 0px 5px;
        margin: 8px 2px 8px 5px;
    }

    #pulseaudio-slider,
    #pulseaudio {
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
    }

    #pulseaudio-slider highlight {
        min-width: 0px;
        border-radius: 5px;
    }

    #network,
    #bluetooth {
        font-size: 22px;
    }

    #bluetooth {
        padding: 0px 5px 0px 10px;
        margin: 5px 0px 5px 5px;
        border-radius: 5px 0px 0px 5px;
    }

    #network {
        padding: 0px 10px 0px 5px;
        margin: 5px 5px 5px 0px;
        border-radius: 0px 5px 5px 0px;
    }

    #idle_inhibitor,
    #battery,
    #power-profiles-daemon {
    }

    #idle_inhibitor {
        padding: 0px 5px 0px 10px;
        margin: 5px 0px 5px 5px;
        border-radius: 5px 0px 0px 5px;
    }

    #power-profiles-daemon {
        padding: 0px 8px 0px 5px;
        margin: 5px 0px 5px 0px;
        border-radius: 0px 0px 0px 0px;
    }

    #power-profiles-daemon.performance {
        font-size: 23px;
        padding: 0px 10px 0px 8px;
    }

    #power-profiles-daemon.power-saver {
        color: #1aa052;
    }

    #battery {
        padding: 0px 10px 0px 5px;
        margin: 5px 5px 5px 0px;
        border-radius: 0px 5px 5px 0px;
    }

    #battery.critical:not(.charging) {
        animation-name: blink;
        animation-duration: 0.5s;
        animation-timing-function: steps(12);
        animation-iteration-count: infinite;
        animation-direction: alternate;
        padding: 0px 10px 0px 5px;
        margin: 5px 5px 5px 0px;
        border-radius: 0px 5px 5px 0px;
    }

    #clock {
        padding: 0px 10px;
        margin: 5px;
    }

    #custom-wlogout {
        padding: 0px 10px 0px 10px;
        font-size: 25px;
        border-radius: 50%;
        margin: 5px;
    }

    #custom-wlogout,
    #custom-reboot,
    #custom-lockscreen,
    #custom-logout {
        padding: 0px 10px;
    }

    #custom-lockscreen {
        margin: 8px 2px 8px 0px;
        border-radius: 0px 5px 5px 0px;
        padding: 0px 10px 0px 5px;
    }

    #custom-reboot {
        margin: 8px 0px 8px 10px;
        border-radius: 5px 0px 0px 5px;
        padding: 0px 5px 0px 10px;
    }

    #custom-logout {
        margin: 8px 0px 8px 0px;
        border-radius: 0px;
    }
  '';
}