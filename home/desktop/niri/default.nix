{ pkgs, ... }:
# Wayland config
{
  imports = [
    ./niri
  ];

  home.packages = with pkgs; [
    # screenshot
    grim
    grimblast
    slurp

    # utils
    mako
    fuzzel
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
}
