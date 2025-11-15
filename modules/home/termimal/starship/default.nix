{ ... }:
{
  programs.starship.enable = true;

  xdg.configFile."starship" = {
    source = ./config;
    recursive = true;
    # executable = true;
  };
}
