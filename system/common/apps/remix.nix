/**
 * system/common/remix.nix
 * Audio production and music creation tools.
 * Includes REAPER DAW, various VST/LV2 plugins, and session managers.
 */
{pkgs, ...}: {
  environment = {
    # System-wide packages for audio production
    systemPackages = with pkgs; [
      # REAPER: A powerful digital audio workstation (DAW)
      reaper
      reaper-reapack-extension
      reaper-sws-extension

      # Session manager for Linux audio applications
      raysession

      # VST/LV2 Plugins & Instruments
      sfizz
      vital
      lsp-plugins
      dragonfly-reverb
    ];
  };
}
