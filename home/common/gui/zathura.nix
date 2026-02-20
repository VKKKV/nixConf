/**
 * home/common/zathura.nix
 * Zathura: A highly customizable and functional document viewer.
 */
{...}: {
  programs.zathura = {
    enable = true;
    options = {
      # Viewing & Navigation settings
      zoom-min = "10";
      scroll-page-aware = "true";
      scroll-full-overlap = "0.01";
      scroll-step = "100";
      
      # UI settings
      statusbar-basename = "true";
      statusbar-home-tilde = "true";
      statusbar-page-percent = "true";
      adjust-open = "best-fit";
      pages-per-row = "1";
      page-h-padding = "0";
      page-v-padding = "0";
      page-right-to-left = "true";
      render-loading = "true";
    };
  };
}
