{ pkgs, username, ... }:
{
  imports = [
    ./boot.nix
    ./config.nix
    ./network.nix
    ./pipewire.nix
    ./system.nix
#    ./virtualization.nix
  ];
  system.stateVersion = "25.11";
}
