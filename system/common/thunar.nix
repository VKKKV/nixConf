/**
 * system/common/thunar.nix
 * Thunar file manager and related components.
 */
{pkgs, ...}: {
  programs.thunar = {
    enable = true;
    plugins = with pkgs.xfce; [
      thunar-archive-plugin
      thunar-volman
    ];
  };

  # Required services for Thunar functionality
  programs.xfconf.enable = true;
  services.gvfs.enable = true; # Mount, trash, and remote filesystem support
  services.tumbler.enable = true; # Thumbnail generation
}
