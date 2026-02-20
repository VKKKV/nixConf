/**
 * home/common/default.nix
 * Unified entry point for all common user-level configurations.
 */
{...}: {
  imports = [
    ./core
    ./dev
    ./gui
    ./shells
    ./terminals
  ];
}
