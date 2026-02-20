/**
 * home/desktop/swaylock.nix
 * Swaylock: Screen locker for Wayland.
 * Uses swaylock-effects for enhanced visual features like blur and pixelation.
 */
{pkgs, ...}: {
  programs.swaylock = {
    enable = true;
    package = pkgs.swaylock-effects;

    settings = {
      # Visual & Functional settings
      clock = true;
      daemonize = true;
      datestr = "";
      screenshots = true;
      ignore-empty-password = true;

      # Indicator appearance
      indicator = true;
      indicator-radius = 111;
      indicator-thickness = 9;

      # Effect settings for the locked screen
      effect-blur = "7x5";
      effect-vignette = "0.75:0.75";
      effect-pixelate = 5;
    };
  };
}
