/**
 * home/common/shells/default.nix
 * Shell configurations and CLI enhancements.
 */
{...}: {
  imports = [
    ./bash.nix
    ./fish.nix
    ./starship.nix
    ./atuin.nix
    ./zoxide.nix
    ./fzf.nix
  ];
}
