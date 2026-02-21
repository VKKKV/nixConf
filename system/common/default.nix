/**
 * system/common/default.nix
 * Unified entry point for all common system-wide configurations.
 */
{...}: {
  imports = [
    ./core.nix
    ./hardware.nix
    ./apps.nix
    ./stylix
  ];
}
