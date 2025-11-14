{ pkgs, ... }:
{
  home.packages = with pkgs; [
    cliphist
    direnv
    kitty
    ghostty
    glib
    grim
    grimblast
    hyprpicker
    localsend
    pavucontrol
    pwvucontrol
    slurp
    swww
    wayland
    wl-clip-persist
  ];

  systemd.user.targets.hyprland-session.Unit.Wants = [
    "xdg-desktop-autostart.target"
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    package = null;
    portalPackage = null;

    xwayland = {
      enable = true;
      hidpi = true;
    };
    # enableNvidiaPatches = false;
    systemd.enable = true;
  };

  xdg.configFile."hypr" = {
    source = ./config;
    recursive = true;
    executable = true;
  };
}
