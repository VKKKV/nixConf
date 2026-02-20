/**
 * home/common/zoxide.nix
 * Zoxide: A smarter cd command that learns your habits.
 */
{...}: {
  programs.zoxide = {
    enable = true;
    enableBashIntegration = true;
  };
}
