{ ... }:
{
  programs.fish = {
    enable = true;
  };
  xdg.configFile."fish" = {
    source = ./config;
    recursive = true;
    # executable = true;
  };
}
