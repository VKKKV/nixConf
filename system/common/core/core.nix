{
  pkgs,
  inputs,
  ...
}: {
  /**
   * system/common/core.nix
   * Core system configuration shared across all hosts.
   * Includes essential system settings, global packages, and basic program configurations.
   */
  system.stateVersion = "25.11";

  # --- Localization & Time ---
  time = {
    timeZone = "Asia/Shanghai";
    hardwareClockInLocalTime = true;
  };

  i18n.defaultLocale = "en_US.UTF-8";

  # --- Resource Management ---
  # Enable zram swap for better performance on systems with limited RAM
  zramSwap = {
    enable = true;
    algorithm = "zstd";
    priority = 5;
    memoryPercent = 30;
  };

  # --- Environment & Shells ---
  environment = {
    # Define available shells
    shells = with pkgs; [
      bashInteractive
      fish
    ];

    # Global system packages
    systemPackages = with pkgs; [
      # Java Runtime
      zulu17

      # Development Tools & Editors
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

      # Network Diagnostics & Tools
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
      wget
      curl
      curlie
      httpie

      # System Monitoring & Hardware Info
      btop
      nmon
      fastfetch
      nvitop
      procs
      duf
      dust
      gdu
      ncdu
      dmidecode
      ethtool
      lm_sensors
      pciutils
      usbutils
      hdparm
      parted

      # Debugging & Tracing
      bpfmon
      bpftop
      bpftrace
      strace
      ltrace

      # File Management & CLI Utilities
      fd
      fzf
      tree
      rsync
      croc
      trashy
      udiskie
      wl-clipboard
      xdg-utils
      which
      killall
      psmisc
      libnotify
      poweralertd
      gnutar
      unzip
      zip
      p7zip
      xz
      zstd

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
      tealdeer

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
      git
      git-lfs
      git-trim
      gitleaks

      # Miscellaneous Utilities
      binsider
      sysbench
      sysstat
      systemctl-tui
      gping
      libargon2
      openssl

      # FHS Environment Script for running non-Nix binaries
      (let
        base = pkgs.appimageTools.defaultFhsEnvArgs;
      in
        pkgs.buildFHSEnv (base
          // {
            name = "fhs";
            targetPkgs = pkgs: (base.targetPkgs pkgs) ++ [pkgs.pkg-config];
            profile = "export FHS=1";
            runScript = "bash";
            extraOutputsToInstall = ["dev"];
          }))
    ];
  };

  # --- Module Imports ---
  imports = [
    inputs.nix-index-database.nixosModules.nix-index
  ];

  # --- Program Configurations ---
  programs = {
    dconf.enable = true;
    bash.enable = true;
    fish.enable = true;
    bcc.enable = true;
    hyprland.enable = true;

    # Nix Helper (nh) for easier system management
    nh = {
      enable = true;
      clean = {
        enable = true;
        extraArgs = "--keep-since 7d --keep 5";
      };
      flake = "/etc/nixos";
    };

    # Command-not-found database integration
    nix-index = {
      enable = true;
      package = pkgs.nix-index;
    };

    nix-index-database.comma.enable = true;

    # GnuPG Agent with SSH support
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
      pinentryPackage = pkgs.pinentry-gtk2;
    };

    # Nix-ld for running unpatched dynamic binaries
    nix-ld = {
      enable = true;
      libraries = with pkgs; [stdenv.cc.cc];
    };
  };
}
