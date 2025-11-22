{ ... }:
let
  custom = {
    font = "Maple Mono";
    font_size = "18px";
    font_weight = "bold";
    text_color = "#FBF1C7";
    background_0 = "#1D2021";
    background_1 = "#282828";
    border_color = "#A89984";
    red = "#CC241D";
    green = "#98971A";
    yellow = "#FABD2F";
    blue = "#458588";
    magenta = "#B16286";
    cyan = "#689D6A";
    orange = "#D65D0E";
    orange_bright = "#FE8019";
    opacity = "1";
    indicator_height = "2px";
  };
in
{
  programs.waybar.style = with custom; ''
        * {
        border: none;
        border-radius: 5px;
        font-family: ${font};
        font-size: ${font_size};
        font-weight: ${font_weight};
        min-height: 0;
        color: ${text_color};
    }

    window#waybar {
        border-radius: 0px;
        background: ${background_0};
        color: ${text_color};
    }

    tooltip {
        background: ${background_1};
        border: 2px solid ${border_color};
        opacity: ${opacity};
    }

    tooltip label {
        color: ${text_color};
        font-size: 16px;
    }

    #workspaces {
        background-color: ${background_1};
        padding: 0px 5px;
        margin: 5px;
    }

    #workspaces button {
        padding: 0px 10px;
        color: ${cyan};
    }

    #workspaces button:hover {
        background: ${background_0};
    }

    #workspaces button.active {
        color: ${orange};
    }

    #mpris,
    #custom-cava {
        background-color: ${background_1};
        color: ${blue};
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
        background-color: ${background_1};
        color: ${orange};
    }

    #custom-wfrec.recording {
        color: ${red};
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
        background-color: ${background_1};
        color: ${text_color};
        margin: 5px
    }

    #window label {
        font-size: 16px;
    }

    window#waybar.empty #window {
        background-color: ${background_0};
    }

    #custom-applauncher {
        font-size: 25px;
        padding: 0px 10px;
        margin: 5px;
        background-color: ${blue};
        color: ${background_0};
    }

    #custom-separator.2 {
        font-size: 28px;
        padding: 0px 5px;
        /* background-color:${blue}; */
        color: ${text_color};
    }

    /* waybar niri taskbar */
    .niri-taskbar {
        background: none;
        padding: 0px;
        margin: 4px;
    }

    .niri-taskbar button:hover {
        background: ${green};
    }

    .niri-taskbar button.focused {
        background: ${green};
    }

    .niri-taskbar button.urgent {
        background-color: ${orange};
        animation-name: blink;
        animation-duration: 0.5s;
        animation-timing-function: steps(12);
        animation-iteration-count: infinite;
        animation-direction: alternate;
    }

    @keyframes blink {
        to {
            background-color: ${blue};
            color: ${red};
        }
    }

    #custom-updates {
        padding: 0px 10px;
        margin: 5px;
        background-color: ${background_1};
        color: ${red};
    }

    #tray {
        padding: 0px 10px;
        background-color: ${background_1};
        margin: 5px;
    }

    #custom-ddcutil-day,
    #custom-ddcutil-night,
    #custom-ddcutil-sleep,
    #custom-separator.1,
    #backlight {
        background-color: ${background_1};
        color: ${yellow};
    }

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
        color: ${yellow};
    }

    #backlight-slider {
        background-color: ${background_1};
        padding: 0px 7px 0px 10px;
        margin: 8px 0px 8px 10px;
        border-radius: 5px 0px 0px 5px
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
        background-color: ${background_0};
    }

    #backlight-slider highlight {
        min-width: 10px;
        border-radius: 5px;
        background-color: ${yellow};
    }

    #pulseaudio {
        /* font-size:20px; */
        padding: 0px 10px;
        margin: 5px;
    }

    #pulseaudio-slider {
        padding: 0px 5px;
        margin: 8px 2px 8px 5px;
    }

    #pulseaudio-slider,
    #pulseaudio {
        background-color: ${background_1};
        color: ${yellow};
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
        background-color: ${background_0};
    }

    #pulseaudio-slider highlight {
        min-width: 0px;
        border-radius: 5px;
        background-color: ${yellow};
    }

    #network,
    #bluetooth {
        background-color: ${background_1};
        color: ${yellow};
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
        background-color: ${background_1};
        color: ${yellow};
    }

    #idle_inhibitor {
        padding: 0px 5px 0px 10px;
        margin: 5px 0px 5px 5px;
        border-radius: 5px 0px 0px 5px;
        color: ${orange};
    }

    #power-profiles-daemon {
        padding: 0px 8px 0px 5px;
        margin: 5px 0px 5px 0px;
        border-radius: 0px 0px 0px 0px;
        color: ${orange};
    }

    #power-profiles-daemon.performance {
        color: ${red};
        font-size: 23px;
        padding: 0px 10px 0px 8px;
    }

    /* #power-profiles-daemon.balanced {
        color: ${text_color};
    } */

    #power-profiles-daemon.power-saver {
        color: ${green};

    }

    #battery {
        padding: 0px 10px 0px 5px;
        margin: 5px 5px 5px 0px;
        border-radius: 0px 5px 5px 0px;
    }

    #battery.critical:not(.charging) {
        background-color: ${red};
        color: ${text_color};
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
        background-color: ${background_1};
        color: ${yellow};
        padding: 0px 10px;
        margin: 5px;
    }

    #custom-wlogout {
        padding: 0px 10px 0px 10px;
        font-size: 25px;
        border-radius: 50%;
        margin: 5px
    }

    #custom-wlogout,
    #custom-reboot,
    #custom-lockscreen,
    #custom-logout {
        color: ${orange};
        padding: 0px 10px;
        background-color: ${background_1};
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

