{ pkgs, inputs, ... }:
{
  programs.niri = {
    enable = true;
    package = inputs.niri.packages.${pkgs.system}.niri-unstable;
  };
  xdg.configFile."niri" = {
    source = ./config;
    recursive = true;
    executable = true;
  };
}
