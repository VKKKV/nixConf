/**
 * home/common/bat.nix
 * Bat: A cat(1) clone with wings (syntax highlighting and Git integration).
 */
{pkgs, ...}: {
  programs.bat = {
    enable = true;
    config = {
      pager = "less -FR"; # Use 'less' as the default pager
    };
    extraPackages = with pkgs.bat-extras; [
      batman # 'man' with bat syntax highlighting
      batpipe # 'less' with bat integration
    ];
  };
}
