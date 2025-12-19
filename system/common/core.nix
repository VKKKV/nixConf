{
  pkgs,
  inputs,
  ...
}: {
  system.stateVersion = "25.11";

  # --- System Settings ---
  time = {
    timeZone = "Asia/Shanghai";
    hardwareClockInLocalTime = true;
  };

  i18n.defaultLocale = "en_US.UTF-8";

  zramSwap = {
    enable = true;
    algorithm = "zstd";
    priority = 5;
    memoryPercent = 30;
  };

  # --- Environment & Shells ---
  environment = {
    # added in nixvim
    # variables.EDITOR = "vim --clean";
    shells = with pkgs; [
      bashInteractive
      fish
    ];

    systemPackages = with pkgs; [
      # Development & Editors
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

      # Databases
      mycli
      pgcli
      mongosh
      sqlite

      # Network & Analysis
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

      # System Monitoring & Hardware
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

      # BPF & Tracing
      bpfmon
      bpftop
      bpftrace
      strace
      ltrace

      # File Management & CLI Tools
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

      # Media (Images/Video/Audio)
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

      # Gaming & Graphics
      heroic
      mangohud
      protonplus
      winetricks
      kicad

      # Internet & Remote Desktop
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

      # Specialized / Utils
      binsider
      sysbench
      sysstat
      systemctl-tui
      gping
      libargon2
      openssl

      # FHS Environment Script
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

  # --- Imports & Modules ---
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

    nh = {
      enable = true;
      clean = {
        enable = true;
        extraArgs = "--keep-since 7d --keep 5";
      };
      flake = "/etc/nixos";
    };

    nix-index = {
      enable = true;
      package = pkgs.nix-index;
    };

    nix-index-database.comma.enable = true;

    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
      pinentryPackage = pkgs.pinentry-gtk2;
    };

    nix-ld = {
      enable = true;
      libraries = with pkgs; [stdenv.cc.cc];
    };
  };
}
