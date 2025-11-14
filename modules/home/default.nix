{ ... }:
{
  imports = [
    # common packages
    ./packages # other packages
    ./bat.nix # better cat command
    ./btop.nix # resouces monitor
    ./fzf.nix # fuzzy finder
    ./git.nix # version control
    ./gtk.nix # gtk theme
    ./lazygit.nix
    ./nix-search # TUI to search nixpkgs
    ./xdg-mimes.nix # xdg config
    ./ssh.nix # ssh config
    ./fish
    ./starship
    ./bash.nix
    ./yazi
    ./vim
    ./tmux
    ./tealdeer.nix

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
