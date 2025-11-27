{ pkgs, osConfig, ... }:
{
  home.packages = with pkgs; [
    mitmproxy # http/https proxy tool
    wireshark # network analyzer

    # IDEs
    jetbrains.idea-community-bin

    ffmpeg-full

    # images
    viu # Terminal image viewer with native support for iTerm and Kitty
    imagemagick
    graphviz

    podman-compose
    dive # explore docker layers
    lazydocker # Docker terminal UI.

    tokei # count lines of code, alternative to cloc

    # db related
    mycli
    pgcli
    mongosh
    sqlite

    # Automatically trims your branches whose tracking remote refs are merged or gone
    # It's really useful when you work on a project for a long time.
    git-trim
    gitleaks

    firefox

    gimp # image editing, I prefer using figma in browser instead of this one
    inkscape # vector graphics
    krita # digital painting
    kicad # 3d printing, electrical engineering

    # https://github.com/flightlessmango/MangoHud
    # a simple overlay program for monitoring FPS, temperature, CPU and GPU load, and more.
    mangohud

    # GUI for installing custom Proton versions like GE_Proton
    # proton - a Wine distribution aimed at gaming
    protonplus
    # Script to install various redistributable runtime libraries in Wine.
    winetricks
    # https://github.com/Open-Wine-Components/umu-launcher
    # a unified launcher for Windows games on Linux
    # umu-launcher

    # Sed-like editor for binary files
    # required by some games to fix problems
    # bbe

    # audio control
    pavucontrol
    playerctl
    pulsemixer
    imv # simple image viewer

    # video/audio tools
    libva-utils
    vdpauinfo
    vulkan-tools
    mesa-demos
    nvitop

    # GUI apps
    # e-book viewer(.epub/.mobi/...)
    # do not support .pdf
    foliate

    # remote desktop(rdp connect)
    remmina
    freerdp # required by remmina

  ];

  programs = {
    # live streaming
    obs-studio = {
      enable = pkgs.stdenv.isx86_64;
      plugins = with pkgs.obs-studio-plugins; [
        # screen capture
        wlrobs
        # obs-ndi
        # obs-nvfbc
        obs-teleport
        # obs-hyperion
        droidcam-obs
        obs-vkcapture
        obs-gstreamer
        input-overlay
        obs-multi-rtmp
        obs-source-clone
        obs-shaderfilter
        obs-source-record
        obs-livesplit-one
        looking-glass-obs
        obs-vintage-filter
        obs-command-source
        obs-move-transition
        obs-backgroundremoval
        # advanced-scene-switcher
        obs-pipewire-audio-capture
        obs-vaapi
        obs-3d-effect
      ];
    };

    # a GUI game launcher for Steam/GoG/Epic
    # https://lutris.net/games?ordering=-popularity
    lutris = {
      enable = true;
      defaultWinePackage = pkgs.proton-ge-bin;
      steamPackage = osConfig.programs.steam.package;
      protonPackages = [ pkgs.proton-ge-bin ];
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
    playerctld.enable = true;

    # auto mount usb drives
    udiskie.enable = true;
    # syncthing.enable = true;
  };

}
