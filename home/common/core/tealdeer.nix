/**
 * home/common/tealdeer.nix
 * Tealdeer: A fast tldr client written in Rust.
 */
{...}: {
  programs.tealdeer = {
    enable = true;
    enableAutoUpdates = true;
    settings = {
      display = {
        compact = false;
        use_pager = true;
      };
      updates = {
        auto_update = false;
        auto_update_interval_hours = 720; # Update tldr pages every 30 days
      };
    };
  };
}
