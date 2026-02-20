/**
 * home/common/atuin.nix
 * Atuin: Magical shell history.
 * Replaces your existing shell history with a SQLite database.
 */
{...}: {
  programs.atuin = {
    enable = true;
    enableBashIntegration = true;
    enableFishIntegration = true;
    enableZshIntegration = true;
    enableNushellIntegration = true;
  };
}
