{ ... }:
{
  programs.atuin = {
    enable = true;
    enableBashIntegration = true;
    enableFishIntegration = true;
    enableZshIntegration = true;
  };
  xdg.configFile."atuin" = {
    source = ./config;
    recursive = true;
    # executable = true;
  };
}
