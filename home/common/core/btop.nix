/**
 * home/common/btop.nix
 * Btop: Resource monitor that shows usage and stats for processor, memory, disks, network and processes.
 */
{pkgs, ...}: {
  programs.btop = {
    enable = true;

    settings = {
      theme_background = false;
      update_ms = 500;
      rounded_corners = false;
    };
  };

  # Additional hardware monitoring tools
  home.packages = with pkgs; [nvtopPackages.intel];
}
