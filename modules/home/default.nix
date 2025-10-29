{ pkgs, ... }:
{
  imports = [
    ./bat.nix # better cat command
    ./browser.nix # firefox based browser
    ./btop.nix # resouces monitor
    ./discord.nix # discord
    ./fastfetch # fetch tool
    ./fzf.nix # fuzzy finder
    ./gaming.nix # packages related to gaming
    ./alacritty # terminal
    ./git.nix # version control
    ./gtk.nix # gtk theme
    ./hyprland # window manager
    ./lazygit.nix
    ./nix-search # TUI to search nixpkgs
    ./packages # other packages
    ./vicinae/vicinae.nix # launcher
    ./xdg-mimes.nix # xdg config

    ./starship
    ./zathura.nix
    ./fish
    ./bash.nix
    ./mpv
    ./yazi
    #./atuin
    ./vim
    ./tmux
    ./tealdeer.nix

    # TODO
    ./gnome.nix # gnome apps
    ./kitty.nix # terminal
    ./waypaper.nix # GUI wallpaper picker
    ./nemo.nix # file manager
    ./waybar # status bar
    # ./scripts/scripts.nix # personal scripts
    # change to thunar
    ./rofi # launcher
    ./p10k
    ./ssh.nix # ssh config
    # to yazi
    # ./superfile/superfile.nix # terminal file manager
    # ./swaylock.nix # lock screen
    # ./swayosd.nix # brightness / volume wiget
    ./swaync/swaync.nix # notification deamon
    # ./vscodium # vscode fork
    ./zsh # shell

  ];
}
