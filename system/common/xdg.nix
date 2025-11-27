{ pkgs, ... }:
{
  xdg.terminal-exec = {
    enable = true;
    package = pkgs.xdg-terminal-exec-mkhl;
    settings =
      let
        my_terminal_desktop = [
          # NOTE: We have add these packages at user level
          "com.mitchellh.ghostty.desktop"
          "kitty.desktop"
          "Alacritty.desktop"
          "foot.desktop"
        ];
      in
      {
        GNOME = my_terminal_desktop ++ [
          "com.raggesilver.BlackBox.desktop"
          "org.gnome.Terminal.desktop"
        ];
        niri = my_terminal_desktop;
        default = my_terminal_desktop;
      };
  };

  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    config = {
      common = {
        default = [
          "gnome"
          "gtk"
        ];
        "org.freedesktop.impl.portal.ScreenCast" = "gnome";
        "org.freedesktop.impl.portal.Screenshot" = "gnome";
        "org.freedesktop.impl.portal.RemoteDesktop" = "gnome";
      };
    };

    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk # for provides file picker / OpenURI
      xdg-desktop-portal-gnome # for screensharing
    ];
  };
}
