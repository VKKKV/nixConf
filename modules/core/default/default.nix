{ pkgs, username, ... }:
{
  imports = [
    ./config.nix
    ./network.nix
    ./pipewire.nix
    ./system.nix
#    ./virtualization.nix
  ];
}
