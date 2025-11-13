{ ... }:
{
  imports = [
    ./default.nix

    # specific packages
    # ./hyprlandLaptop
    ./niri
    ./waybar # status bar
    ./discord.nix # discord
    ./gaming.nix # packages related to gaming
    ./vscodium # vscode fork
    ./thunar.nix
    # ./alacritty # terminal
    # ./vicinae/vicinae.nix # launcher
    # ./gnome.nix # gnome apps
    # ./kitty.nix # terminal
    # ./waypaper.nix # GUI wallpaper picker
    # ./nemo.nix # file manager
    # ./rofi # launcher
    # ./swaync/swaync.nix # notification deamon
    # ./swaylock.nix # lock screen
    # ./swayosd.nix # brightness / volume wiget
    # ./atuin
  ];
}
