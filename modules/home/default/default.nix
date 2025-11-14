{ ... }:
{
  imports = [
    ./atuin.nix
    ./bash.nix
    ./bat.nix # better cat command
    ./btop.nix # resouces monitor
    ./fish
    ./fonts.nix
    ./fzf.nix # fuzzy finder
    ./git.nix # version control
    ./gtk.nix # gtk theme
    ./lazygit.nix
    ./packages.nix # other packages
    ./ssh.nix # ssh config
    ./starship
    ./tealdeer.nix
    ./tmux
    ./vim
    ./xdg-mimes.nix # xdg config
    ./yazi
    ./zoxide.nix
  ];
}
