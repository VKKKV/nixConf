/**
 * home/common/core/default.nix
 * Core user-level configuration and utilities.
 */
{...}: {
  imports = [
    ./core.nix
    ./packages.nix
    ./bat.nix
    ./btop.nix
    ./tealdeer.nix
    ./xdg-mimes.nix
  ];
}
