{ pkgs, ... }:

{
  programs.waybar = {
    enable = true;
    package = pkgs.waybar;
  };

  xdg.configFile."waybar/scripts" = {
    source = ./scripts;
    recursive = true;
    executable = true;
};
}