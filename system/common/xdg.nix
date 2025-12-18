{pkgs, ...}: {
  xdg.terminal-exec = {
    enable = true;
    package = pkgs.xdg-terminal-exec-mkhl;
    settings = let
      my_terminal_desktop = [
        "com.mitchellh.ghostty.desktop"
        "kitty.desktop"
        "Alacritty.desktop"
        "foot.desktop"
      ];
    in {
      Hyprland = my_terminal_desktop;
      default = my_terminal_desktop;
      GNOME =
        my_terminal_desktop
        ++ [
          "com.raggesilver.BlackBox.desktop"
          "org.gnome.Terminal.desktop"
        ];
    };
  };

  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    config = {
      common = {
        default = ["gtk"];
      };
      hyprland = {
        default = ["hyprland" "gtk"];
        # "org.freedesktop.impl.portal.Screenshots" = [ "hyprland" ];
        # "org.freedesktop.impl.portal.ScreenCast" = [ "hyprland" ];
      };
    };

    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-hyprland
    ];
  };
}
