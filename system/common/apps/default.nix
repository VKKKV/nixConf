/**
 * system/common/apps/default.nix
 * Common system-wide applications and fonts.
 */
{...}: {
  imports = [
    ./flatpak.nix
    ./fonts.nix
    ./game.nix
    ./minecraft.nix
    ./remix.nix
    ./thunar.nix
    ./virtualization.nix
  ];
}
