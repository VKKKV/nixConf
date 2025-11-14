{ ... }:
{
  imports = [
    # home modules
    ./packages.nix
    ./hyprlandLaptop
    ./waybar # status bar
    ./discord.nix # discord
    ./vscodium # vscode fork
    ./ghostty
    ./browser.nix
    ./atuin
  ];
}
