/**
 * home/desktop/hyprland/default.nix
 * Hyprland window manager configuration and service setup.
 * Handles common settings and host-specific overrides (e.g., laptop monitor scaling).
 */
{
  host,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.desktop.hyprland;
in {
  options.modules.desktop.hyprland = {
    enable = mkOption {
      type = types.bool;
      default = true;
      description = "Hyprland window manager";
    };
  };

  config = mkIf cfg.enable {
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
        env = LIBVA_DRIVER_NAME,nvidia
        env = NVD_BACKEND,direct
        env = __GLX_VENDOR_LIBRARY_NAME,nvidia
        env = GBM_BACKEND,nvidia-drm
        cursor:no_hardware_cursors = true
      ''
      else "";
  };
}
