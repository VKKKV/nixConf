{ pkgs, ... }:
# Wayland config
{
  imports = [
    ./niri
    ./waybarShorin/waybar.nix
    ./quickshell.nix
  ];

  home.packages = with pkgs; [
    # screenshot
    grim
    grimblast
    slurp

    # utils
    fuzzel
    wl-clipboard
    wl-clip-persist
    localsend
    pwvucontrol
    cliphist
  ];

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

  services = {
    mako = {
      enable = true;
      settings = {
        # Default settings for normal notifications
        border-radius = 8;
        border-size = 2;
        border-color = "#8aadf4"; # Normal border color (blue)
        default-timeout = 8000;
        height = 100;
        icons = true;
        ignore-timeout = false;
        layer = "top";
        margin = 10;
        markup = true;
        width = 300;

        # Settings for actionable notifications
        "actionable=true" = {
          anchor = "top-left";
        };
        actions = true;
        anchor = "top-right";

        # Settings for urgent notifications
        "urgency=high" = {
          border-color = "#ed8796"; # Urgent border color (red)
          default-timeout = 0; # Don't timeout urgent notifications
        };
      };
    };
    swww = {
      enable = true;
    };
  };
}
