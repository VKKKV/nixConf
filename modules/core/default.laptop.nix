{ ... }:
{
  imports = [
    ./default.nix

    ./hardware.nix
    ./flatpak.nix
    ./steam.nix
    ./user.nix
  ];
}
