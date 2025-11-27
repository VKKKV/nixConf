{ ... }:
{
  programs.zathura = {
    enable = true;
    options = {
      zoom-min = "10";
      scroll-page-aware = "true";
      scroll-full-overlap = "0.01";
      scroll-step = "100";
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
