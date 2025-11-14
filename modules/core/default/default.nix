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
}
