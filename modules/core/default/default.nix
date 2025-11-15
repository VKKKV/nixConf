{ pkgs, username, ... }:
{
  imports = [
    ./boot.nix
    ./config.nix
    ./network.nix
    ./nix.nix
    ./services.nix
#    ./virtualization.nix
  ];
}
