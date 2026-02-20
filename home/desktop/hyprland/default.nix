/**
 * home/desktop/hyprland/default.nix
 * Hyprland window manager configuration and service setup.
 */
/**
 * home/desktop/hyprland/default.nix
 * Hyprland window manager configuration and service setup.
 * Handles common settings and host-specific overrides (e.g., laptop monitor scaling).
 */
{host, ...}: {
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

  # Host-specific Hyprland configuration
  xdg.configFile."hypr/host.conf".text =
    if host == "laptop"
    then ''
      # Laptop-specific settings
      monitor = eDP-1, 3200x2000@90, 0x0, 1.6

      # Lid switch handling
      bindl = , switch:off:Lid Switch, exec, hyprctl dispatch dpms on
      bindl = , switch:on:Lid Switch, exec, hyprctl dispatch dpms off
    ''
    else if host == "desktop"
    then ''
      # Desktop-specific settings
      # monitor = , preferred, auto, 1
    ''
    else "";
}
