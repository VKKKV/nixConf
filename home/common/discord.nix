/**
 * home/common/discord.nix
 * Discord client configuration.
 * Uses WebCord with Vencord for enhanced features and privacy.
 */
{pkgs, ...}: {
  home.packages = with pkgs; [
    webcord-vencord
  ];
}
