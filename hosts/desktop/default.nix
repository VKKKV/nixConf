{ ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./../../modules
  ];

  powerManagement.cpuFreqGovernor = "performance";
}
