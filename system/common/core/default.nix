/**
 * system/common/core/default.nix
 * Core system settings and user management.
 */
{...}: {
  imports = [
    ./boot.nix
    ./core.nix
    ./home-manager.nix
    ./network.nix
    ./nix.nix
    ./security.nix
    ./services.nix
    ./xdg.nix
  ];
}
