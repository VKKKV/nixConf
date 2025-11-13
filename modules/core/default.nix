{ ... }:
{
  imports = [
    # core modules
    ./nixpkgs.nix
    ./bootloader.nix
    ./xserver.nix
    ./network.nix
    ./pipewire.nix
    ./program.nix
    ./security.nix
    ./services.nix
    ./system.nix
    # ./wayland.nix
    ./virtualization.nix
  ];
}
