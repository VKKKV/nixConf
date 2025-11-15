{ ... }:
{
  imports = [
    ./atuin.nix
    ./bash.nix
    ./bat.nix # better cat command
    ./btop.nix # resouces monitor
    ./fish
    ./fzf.nix # fuzzy finder
    ./git.nix # version control
    ./lazygit.nix
    ./packages.nix # other packages
    ./ssh.nix # ssh config
    ./starship
    ./tealdeer.nix
    ./tmux
    ./vim
    ./yazi
    ./zoxide.nix
  ];
}
