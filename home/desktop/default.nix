/**
 * home/desktop/default.nix
 * Entry point for desktop environment configuration (Hyprland).
 * Includes common desktop packages and imports specialized UI modules.
 */
{pkgs, ...}: {
  imports = [
    # ./niri
    ./hyprland
    ./rofi
    ./waybar
  ];

  home.packages = with pkgs; [
    satty
    tesseract
    blueberry # Bluetooth GUI
    blueman # Bluetooth management
    bluez # Bluetooth protocol stack
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
    libnotify # Notification utilities
    localsend
    networkmanager # For nmtui
    pavucontrol # PulseAudio control panel
    playerctl # MPRIS media control
    power-profiles-daemon
    pwvucontrol
    slurp # Region selection
    swaynotificationcenter # Notification center
    swww
    udisks2 # Disk management for tray icons
    upower # Battery status
    wayland
    waypaper # Wallpaper selector
    wireplumber # wpctl audio control
    wl-clip-persist
    wl-clipboard # Wayland clipboard (wl-copy)
    wlogout # Power menu interface
  ];
}
