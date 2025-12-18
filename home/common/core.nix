{
  pkgs,
  osConfig,
  ...
}: {
  programs = {
    # Live streaming and recording
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

    # Game launcher and compatibility layers
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

  services = {
    playerctld.enable = true; # Media player daemon
    udiskie.enable = true; # Auto-mount USB drives
    # syncthing.enable = true;
  };
}
