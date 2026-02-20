/**
 * home/common/terminals/default.nix
 * Terminal emulators and multiplexers.
 */
{...}: {
  imports = [
    ./kitty.nix
    ./ghostty.nix
    ./tmux.nix
  ];
}
