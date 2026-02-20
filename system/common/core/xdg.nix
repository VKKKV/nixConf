/**
 * system/common/xdg.nix
 * XDG desktop integration and portals.
 * Manages default terminals and portal integrations for cross-desktop compatibility.
 */
{pkgs, ...}: {
  xdg.terminal-exec = {
    enable = true;
    package = pkgs.xdg-terminal-exec-mkhl;
    settings = let
      # Prioritized list of preferred terminal emulators
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

  # XDG Portals for Wayland and Flatpak integration
  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    config = {
      common = {
        default = ["gtk"];
      };
      hyprland = {
        default = ["hyprland" "gtk"];
      };
    };

    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-hyprland
    ];
  };
}
