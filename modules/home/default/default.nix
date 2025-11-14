{ ... }:
{
  imports = [
    # common packages
    ./packages.nix # other packages
    ./bat.nix # better cat command
    ./btop.nix # resouces monitor
    ./fzf.nix # fuzzy finder
    ./git.nix # version control
    ./gtk.nix # gtk theme
    ./lazygit.nix
    ./xdg-mimes.nix # xdg config
    ./ssh.nix # ssh config
    ./fish
    ./starship
    ./bash.nix
    ./yazi
    ./vim
    ./tmux
    ./tealdeer.nix
    ./zoxide.nix
    ./atuin.nix
  ];
}
