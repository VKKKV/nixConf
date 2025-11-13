{ pkgs, ... }:
{
  imports = [
    # common packages
    ./bat.nix # better cat command
    ./browser.nix # firefox based browser
    ./btop.nix # resouces monitor
    ./fzf.nix # fuzzy finder
    ./git.nix # version control
    ./gtk.nix # gtk theme
    ./lazygit.nix
    ./nix-search # TUI to search nixpkgs
    ./packages # other packages
    ./xdg-mimes.nix # xdg config
    ./ssh.nix # ssh config
    ./fish
    ./starship
    ./zathura.nix
    ./bash.nix
    ./mpv
    ./yazi
    ./vim
    ./tmux
    ./tealdeer.nix
    ./fcitx5

    # specific packages
    # ./discord.nix # discord
    # ./gaming.nix # packages related to gaming
    # ./vscodium # vscode fork
    # ./alacritty # terminal
    # ./vicinae/vicinae.nix # launcher
    # ./gnome.nix # gnome apps
    # ./kitty.nix # terminal
    # ./waypaper.nix # GUI wallpaper picker
    # ./nemo.nix # file manager
    # ./waybar # status bar
    # ./thunar.nix
    # ./rofi # launcher
    # ./swaync/swaync.nix # notification deamon
    # ./hyprland # window manager
    # ./swaylock.nix # lock screen
    # ./swayosd.nix # brightness / volume wiget
    # ./atuin
  ];
}
