{
  pkgs,
  osConfig,
  ...
}: {
  /**
   * home/common/core.nix
   * Shared user-level configuration for all hosts.
   * Includes high-level program settings and user-specific services.
   */

  programs = {
    # OBS Studio: A feature-rich software for video recording and live streaming.
    obs-studio = {
      enable = pkgs.stdenv.isx86_64;
      plugins = with pkgs.obs-studio-plugins; [
        # Video Capture & Sources
        wlrobs # Wayland screen capture
        obs-vkcapture # Vulkan/OpenGL capture
        obs-vaapi # Hardware encoding
        looking-glass-obs # KVM Framebuffer source
        droidcam-obs # Phone as camera
        obs-gstreamer # GStreamer source/sink

        # Audio & Networking
        obs-pipewire-audio-capture
        obs-teleport # NDI-like streaming over network
        obs-multi-rtmp # Stream to multiple sites

        # Filters & Effects
        obs-shaderfilter
        obs-vintage-filter
        obs-backgroundremoval
        obs-3d-effect

        # Scene & Source Control
        obs-source-clone
        obs-source-record # Record specific sources
        obs-move-transition
        obs-command-source

        # Overlays & Tools
        input-overlay
        obs-livesplit-one
      ];
    };

    # Lutris: Open-source gaming platform for GNU/Linux.
    # Manages game launchers and compatibility layers like Wine/Proton.
    lutris = {
      enable = true;
      steamPackage = osConfig.programs.steam.package;
      defaultWinePackage = pkgs.proton-ge-bin;

      protonPackages = [
        pkgs.proton-ge-bin
      ];

      winePackages = with pkgs; [
        wineWow64Packages.full
        wineWowPackages.stagingFull
      ];

      extraPackages = with pkgs; [
        winetricks
        gamescope
        gamemode
        mangohud
        umu-launcher
      ];
    };
  };

  # --- User Services ---
  services = {
    # Media player daemon for remote control via playerctl
    playerctld.enable = true;

    # Auto-mounting service for removable media (USB drives, etc.)
    udiskie.enable = true;

    # Syncthing: Continuous file synchronization service (currently disabled)
    # syncthing.enable = true;
  };
}
