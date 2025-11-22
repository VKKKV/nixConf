{ pkgs, ... }:
# Wayland config
{
  imports = [
    ./niri
    ./waybarShorin
    ./quickshell.nix
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
        "actionable=true" = {
          anchor = "top-left";
        };
        actions = true;
        anchor = "top-right";
        border-radius = 8;
        default-timeout = 8000;
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
