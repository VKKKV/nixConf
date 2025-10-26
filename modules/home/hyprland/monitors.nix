{ pkgs, ... }:
{
  wayland.windowManager.hyprland = {
    settings.monitor = [ ",preferred,auto,auto" ];

    extraConfig = ''
      source = ~/.config/hypr/monitors.conf
    '';
  };

  home.packages = with pkgs; [ nwg-displays ];
}
