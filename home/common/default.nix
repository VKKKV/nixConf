/**
 * home/common/default.nix
 * Unified entry point for all common user-level configurations.
 */
{...}: {
  imports = [
    ./core.nix
    ./dev
    ./gui
    ./shells.nix
    ./terminals.nix
  ];
}
