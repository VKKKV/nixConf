/**
 * home/desktop/hyprland/default.nix
 * Hyprland window manager configuration and service setup.
 */
{...}: {
  systemd.user.targets.hyprland-session.Unit.Wants = [
    "xdg-desktop-autostart.target"
  ];

  services = {
    swww = {
      enable = true;
    };
  };

  wayland.windowManager.hyprland = {
    enable = true;
    package = null;
    portalPackage = null;

    xwayland = {
      enable = true;
    };
    systemd.enable = true;
  };

  xdg.configFile."hypr" = {
    source = ./config;
    recursive = true;
    executable = true;
  };
}
