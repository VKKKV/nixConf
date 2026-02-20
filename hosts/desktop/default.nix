/**
 * hosts/desktop/default.nix
 * Host-specific configuration for the performance-oriented desktop.
 */
{...}: {
  imports = [
    ./hardware-configuration.nix
    ../../system/common
  ];

  powerManagement.cpuFreqGovernor = "performance";
}
