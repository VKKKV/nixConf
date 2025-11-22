{ pkgs, ... }:

{
  programs.waybar = {
    enable = true;
  };

  xdg.configFile."waybar/scripts" = {
    source = ./scripts;
    recursive = true;
    executable = true;
  };
}

