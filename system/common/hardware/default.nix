/**
 * system/common/hardware/default.nix
 * Common hardware-related configurations.
 */
{...}: {
  imports = [
    ./hardware.nix
    ./qmk.nix
  ];
}
