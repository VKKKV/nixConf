{
  pkgs,
  lib,
  config,
  ...
}:
with lib; {
  config = mkIf config.modules.desktop.enable {
    home.packages = with pkgs; [rofi];
    xdg.configFile."rofi" = {
      source = ./config;
      recursive = true;
      executable = true;
    };
  };
}
