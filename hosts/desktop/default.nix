/**
 * hosts/desktop/default.nix
 * Host-specific configuration for the performance-oriented desktop.
 * Profile: AMD CPU + NVIDIA GPU.
 */
{...}: {
  imports = [
    ./hardware-configuration.nix
    ../../system/common
    ../../system/hardware/cpu/amd.nix
    ../../system/hardware/gpu/nvidia.nix
    ../../system/hardware/device/desktop.nix
  ];
}
