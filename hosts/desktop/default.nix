{ ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./../../modules/default.desktop.nix
  ];

  powerManagement.cpuFreqGovernor = "performance";
}
