{
  pkgs,
  inputs,
  ...
}:
{
  system.stateVersion = "25.11";

  environment = {
    variables.EDITOR = "vim --clean";
    shells = with pkgs; [
      bashInteractive
      fish
    ];

    systemPackages = with pkgs; [
      (ripgrep.override { withPCRE2 = true; })
      aria2 # A lightweight multi-protocol & multi-source command-line download utility
      bash
      bpfmon # BPF based visual packet rate monitor
      bpftop # monitor BPF programs
      bpftrace # powerful tracing tool
      btop
      calc # Calculator
      cloc # Count lines of code
      croc # File transfer between computers securely and easily
      curl
      curlie # curl with httpie
      dmidecode # a tool that reads information about your system's hardware from the BIOS according to the SMBIOS/DMI standard
      dnsutils # `dig` + `nslookup`
      doggo # DNS client for humans
      duf # Disk Usage/Free Utility - a better 'df' alternative
      dust # A more intuitive version of `du` in rust
      ethtool
      fastfetch # System information - lighter than neofetch
      fd # Find files - faster than find
      ffmpeg # Only if you work with media files
      file
      findutils
      fish # nushell
      fzf
      gawk # GNU awk, a pattern scanning and processing language
      gcc
      gdu # disk usage analyzer(replacement of `du`)
      git # used by nix flakes
      git-lfs # used by huggingface models
      gnugrep # GNU grep, provides `grep`/`egrep`/`fgrep`
      gnumake # Makefile
      gnused # GNU sed, very powerful(mainly for replacing text in files)
      gnutar
      gping # ping, but with a graph(TUI)
      hdparm # for disk performance, command
      httpie
      hyperfine # command-line benchmarking tool
      iftop
      imagemagick # Image manipulation
      iotop-c
      ipcalc # it is a calculator for the IPv4/v6 addresses
      iperf3 # network performance test
      jc # converts the output of popular cli tools & file-types to JSON, YAML
      jq # A lightweight and flexible command-line JSON processor
      killall # Process management
      ldns # replacement of `dig`, it provide the command `drill`
      libargon2
      libnotify # Desktop notifications
      lm_sensors # for `sensors` command
      localsend
      lsof # list open files
      ltrace # library call monitoring
      mtr # A network diagnostic tool(traceroute)
      ncdu # analyzer your disk usage Interactively, via TUI(replacement of `du`)
      nil
      nixd
      nixfmt
      nmap # A utility for network discovery and security auditing
      nmon
      nodejs_24
      openssl # Cryptography
      p7zip # Archive extraction
      parted
      pavucontrol
      pciutils # lspci
      poweralertd # Power management notifications
      procs # a moreden ps
      psmisc # killall/pstree/prtstat/fuser/...
      pwvucontrol
      ripgrep # Search in files - faster than grep
      rsync
      sad # CLI search and replace, just like sed, but with diff preview.
      socat # replacement of openbsd-netcat
      strace # system call monitoring
      sysbench
      sysstat
      systemctl-tui
      tcpdump # network sniffer
      tealdeer # a very fast version of tldr
      tree
      udiskie # USB device management
      unzip # Archive extraction
      unzipNLS
      usbutils # lsusb
      wget # File downloading
      wl-clipboard
      which
      xdg-utils # Desktop integration
      xz
      yq-go # yaml processor https://github.com/mikefarah/yq
      zip
      zsh
      zstd
      # create a fhs environment by command `fhs`, so we can run non-nixos packages in nixos!
      (
        let
          base = pkgs.appimageTools.defaultFhsEnvArgs;
        in
        pkgs.buildFHSEnv (
          base
          // {
            name = "fhs";
            targetPkgs = pkgs: (base.targetPkgs pkgs) ++ [ pkgs.pkg-config ];
            profile = "export FHS=1";
            runScript = "bash";
            extraOutputsToInstall = [ "dev" ];
          }
        )
      )
    ];
  };

  imports = [
    inputs.nix-index-database.nixosModules.nix-index
  ];

  programs = {
    dconf.enable = true;
    bash.enable = true;
    fish.enable = true;
    bcc.enable = true;

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
      # symlinkToCacheHome = true;
      enableZshIntegration = false;
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
      libraries = with pkgs; [
        stdenv.cc.cc
      ];
    };
  };

  zramSwap = {
    enable = true;
    algorithm = "zstd";
    priority = 5;
    memoryPercent = 30;
  };

  time = {
    timeZone = "Asia/Shanghai";
    hardwareClockInLocalTime = true;
  };

  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "es_US.UTF-8";
      LC_IDENTIFICATION = "es_US.UTF-8";
      LC_MEASUREMENT = "es_US.UTF-8";
      LC_MONETUSY = "es_US.UTF-8";
      LC_NAME = "es_US.UTF-8";
      LC_NUMERIC = "es_US.UTF-8";
      LC_PAPER = "es_US.UTF-8";
      LC_TELEPHONE = "es_US.UTF-8";
      LC_TIME = "es_US.UTF-8";
    };
  };
}
