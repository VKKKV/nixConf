{ ... }:
{
  imports = [
    # core modules
    ./core/default.nix
    ./core/flatpak.nix
    ./core/wayland.nix
    ./core/thunar.nix
    ./core/user.nix

    # home modules
    ./home/default.nix
    ./home/hyprlandLaptop
    ./home/waybar # status bar
    ./home/discord.nix # discord
    ./home/vscodium # vscode fork
    ./home/ghostty
    ./home/browser.nix
    ./home/atuin
  ];
}
