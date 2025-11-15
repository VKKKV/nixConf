{ pkgs, username, ... }:
{
  imports = [
    ./boot.nix
    ./config.nix
    ./network.nix
    ./pipewire.nix
    ./nix.nix
#    ./virtualization.nix
  ];
}
