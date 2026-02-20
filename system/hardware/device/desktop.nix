/**
 * system/hardware/device/desktop.nix
 * Desktop specific hardware configurations.
 * Focused on performance and stability.
 */
{...}: {
  powerManagement.cpuFreqGovernor = "performance";
}
