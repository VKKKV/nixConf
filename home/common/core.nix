{
  pkgs,
  osConfig,
  ...
}: {
  /**
   * home/common/core/default.nix
   * Core user-level configuration and package management.
   */

  # --- CLI Programs ---
  programs = {
    # Bat: A cat(1) clone with wings
    bat = {
      enable = true;
      config.pager = "less -FR";
      extraPackages = with pkgs.bat-extras; [
        batman
        batpipe
      ];
    };

    # Btop: Resource monitor
    btop = {
      enable = true;
      settings = {
        theme_background = false;
        update_ms = 500;
        rounded_corners = false;
      };
    };

    # Tealdeer: A fast tldr client
    tealdeer = {
      enable = true;
      enableAutoUpdates = true;
      settings = {
        display = {
          compact = false;
          use_pager = true;
        };
        updates = {
          auto_update = false;
          auto_update_interval_hours = 720;
        };
      };
    };

    # OBS Studio
    obs-studio = {
      enable = pkgs.stdenv.isx86_64;
      plugins = with pkgs.obs-studio-plugins; [
        wlrobs
        obs-vkcapture
        obs-vaapi
        looking-glass-obs
        droidcam-obs
        obs-gstreamer
        obs-pipewire-audio-capture
        obs-teleport
        obs-multi-rtmp
        obs-shaderfilter
        obs-vintage-filter
        obs-backgroundremoval
        obs-3d-effect
        obs-source-clone
        obs-source-record
        obs-move-transition
        obs-command-source
        input-overlay
        obs-livesplit-one
      ];
    };

    # Lutris
    lutris = {
      enable = true;
      steamPackage = osConfig.programs.steam.package;
      defaultWinePackage = pkgs.proton-ge-bin;
      protonPackages = [pkgs.proton-ge-bin];
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
    playerctld.enable = true;
    udiskie.enable = true;
  };

  # --- XDG Configuration ---
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "text/html" = "zen.desktop";
      "x-scheme-handler/http" = "zen.desktop";
      "x-scheme-handler/https" = "zen.desktop";
      "x-scheme-handler/about" = "zen.desktop";
      "x-scheme-handler/unknown" = "zen.desktop";
      "image/png" = ["imv.desktop" "gimp.desktop"];
      "image/jpeg" = ["imv.desktop" "gimp.desktop"];
      "video/mp4" = "mpv.desktop";
      "video/x-matroska" = "mpv.desktop";
      "application/pdf" = "org.pwmt.zathura.desktop";
    };
  };

  # --- User Packages ---
  home.packages = with pkgs; [
    # Hardware monitoring
    nvtopPackages.intel

    # Java Runtime
    zulu17

    # Development Tools
    (ripgrep.override {withPCRE2 = true;})
    alejandra
    jetbrains.idea-community-bin
    nil
    nixd
    nixfmt
    gcc
    gnumake
    nodejs_24
    tokei
    cloc

    # Container & Virtualization
    podman-compose
    dive
    lazydocker

    # Database Clients
    mycli
    pgcli
    mongosh
    sqlite

    # Network Diagnostics
    wireshark
    mitmproxy
    nmap
    tcpdump
    mtr
    iperf3
    doggo
    dnsutils
    ldns
    socat
    aria2
    curlie
    httpie

    # System Monitoring
    nmon
    fastfetch
    nvitop
    procs
    duf
    dust
    gdu
    ncdu

    # Debugging
    bpfmon
    bpftop
    bpftrace
    strace
    ltrace

    # File Management
    fd
    fzf
    tree
    rsync
    croc
    trashy

    # Text Processing
    jq
    yq-go
    jc
    gnused
    gawk
    gnugrep
    sad
    hyperfine
    calc

    # Multimedia & Graphics
    ffmpeg-full
    imagemagick
    graphviz
    imv
    viu
    foliate
    pavucontrol
    pwvucontrol
    playerctl
    pulsemixer
    libva-utils
    vdpauinfo
    vulkan-tools
    mesa-demos

    # Gaming & Compatibility
    heroic
    mangohud
    protonplus
    winetricks
    kicad

    # Web Browsers & Communication
    google-chrome
    firefox
    remmina
    freerdp
    moonlight-qt
    localsend

    # Version Control
    git-lfs
    git-trim
    gitleaks

    # Miscellaneous
    binsider
    sysbench
    sysstat
    systemctl-tui
    gping
    libargon2
  ];
}
