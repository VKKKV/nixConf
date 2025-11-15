{ ... }:
{
  programs.starship = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    enableFishIntegration = true;
  };

  xdg.configFile."starship" = {
    source = ./config;
    recursive = true;
    # executable = true;
  };
}
