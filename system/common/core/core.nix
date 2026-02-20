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

    # Core system packages
    systemPackages = with pkgs; [
      # Essential tools
      wget
      curl
      git # Required for flakes

      # Hardware utilities
      pciutils
      usbutils
      dmidecode
      ethtool
      lm_sensors
      hdparm
      parted

      # Basic CLI utilities
      which
      killall
      psmisc
      libnotify
      udiskie
      wl-clipboard
      xdg-utils

      # Compression utilities
      gnutar
      unzip
      zip
      p7zip
      xz
      zstd

      # Security & Crypto
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
