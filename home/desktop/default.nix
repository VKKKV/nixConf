/**
* home/desktop/default.nix
* Entry point for desktop environment configuration.
* Includes common desktop packages and imports specialized UI modules.
*/
{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.desktop;
in {
  options.modules.desktop = {
    enable = mkOption {
      type = types.bool;
      default = true;
      description = "Enable desktop environment common components";
    };
  };

  imports = [
    ./hyprland
    ./rofi
    ./waybar.nix
    ./swaync
    ./xmcl.nix
  ];

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      satty
      tesseract
      blueberry # Bluetooth GUI
      blueman # Bluetooth management
      bluez-tools
      cava # Audio visualizer
      cliphist
      ddcutil # Monitor brightness control
      direnv
      fuzzel # Application launcher
      glib
      gnome-calendar
      gnome-clocks
      grim # Screenshot capture
      grimblast
      hyprpicker # Color picker
      power-profiles-daemon
      slurp # Region selection
      swww
      wayland
      waypaper # Wallpaper selector
      wl-clip-persist
      wlogout # Power menu interface
    ];
  };
}
