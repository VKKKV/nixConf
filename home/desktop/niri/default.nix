{ pkgs, ... }:
# Wayland config
{
  imports = [
    ./niri
    ./waybarShorin
  ];

  home.packages = with pkgs; [
    # screenshot
    grim
    grimblast
    slurp

    # utils
    fuzzel
    ghostty
    wl-clipboard
    wl-clip-persist
    localsend
    pwvucontrol
    cliphist
    swayidle
    swaylock
    waybar
  ];

  # make stuff work on wayland
  home.sessionVariables = {
    QT_QPA_PLATFORM = "wayland";
    QT_QPA_PLATFORMTHEME = "gtk3";
    SDL_VIDEODRIVER = "wayland";
    XDG_SESSION_TYPE = "wayland";
  };

  services = {
    mako = {
      enable = true;
      settings = {
        "actionable=true" = {
          anchor = "top-left";
        };
        actions = true;
        anchor = "top-right";
        background-color = "#000000";
        border-color = "#FFFFFF";
        border-radius = 8;
        default-timeout = 8000;
        font = "monospace 10";
        height = 100;
        icons = true;
        ignore-timeout = false;
        layer = "top";
        margin = 10;
        markup = true;
        width = 300;
      };
    };
    swww = {
      enable = true;
    };
  };

}
