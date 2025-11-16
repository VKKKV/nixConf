{ ... }:
{
  imports = [
    ./hyprlandLaptop

    ./browser.nix
    ./fcitx5
    ./ghostty
    ./mpv
    ./rofi
    ./vscodium # vscode fork
    ./waybar # status bar
    ./zathura.nix
    ./discord.nix # discord
    ./xdg-mimes.nix
    ./gtk.nix
  ];
}
