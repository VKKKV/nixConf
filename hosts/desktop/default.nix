/**
 * hosts/desktop/default.nix
 * Host-specific configuration for the performance-oriented desktop.
 */
{...}: {
  imports = [
    ./hardware-configuration.nix
  ];

  powerManagement.cpuFreqGovernor = "performance";
}
