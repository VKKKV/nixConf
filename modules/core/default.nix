{ ... }:
{
  imports = [
    # core modules
    ./nixpkgs.nix
    ./bootloader.nix
    ./hardware.nix
    ./xserver.nix
    ./network.nix
    ./pipewire.nix
    ./program.nix
    ./security.nix
    ./services.nix
    ./steam.nix
    ./system.nix
    ./wayland.nix
    ./virtualization.nix
    # ./flatpak.nix

    # user modules
    ./user.nix
  ];
}
