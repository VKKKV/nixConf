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

    xdg.configFile."hypr/host.conf".source =
      if host == "laptop"
      then ./hosts/laptop.conf
      else if host == "desktop"
      then ./hosts/desktop.conf
      else throw "Unsupported Hyprland host: ${host}";
  };
}
