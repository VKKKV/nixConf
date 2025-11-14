{ ... }:
{
  imports = [
    # common packages
    ./default/packages.nix # other packages
    ./default/bat.nix # better cat command
    ./default/btop.nix # resouces monitor
    ./default/fzf.nix # fuzzy finder
    ./default/git.nix # version control
    ./default/gtk.nix # gtk theme
    ./default/lazygit.nix
    ./default/xdg-mimes.nix # xdg config
    ./default/ssh.nix # ssh config
    ./default/fish
    ./default/starship
    ./default/bash.nix
    ./default/yazi
    ./default/vim
    ./default/tmux
    ./default/tealdeer.nix
    ./default/zoxide.nix
    ./default/atuin.nix
  ];
}
