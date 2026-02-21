{
  pkgs,
  inputs,
  username,
  host,
  ...
}: {
  /**
   * system/common/core/default.nix
   * Consolidated core system-wide and home-manager configurations.
   */

  imports = [
    inputs.nix-index-database.nixosModules.nix-index
    inputs.home-manager.nixosModules.home-manager
  ];

  system.stateVersion = "25.11";

  # --- Home Manager ---
  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    extraSpecialArgs = {inherit inputs username host;};
    users.${username} = {
      imports = [../../../home];
      home.username = "${username}";
      home.homeDirectory = "/home/${username}";
      home.stateVersion = "25.11";
      programs.home-manager.enable = true;
    };
    backupFileExtension = "hm-backup";
  };

  # --- User Accounts ---
  users.users.${username} = {
    isNormalUser = true;
    description = "${username}";
    extraGroups = [
      "users"
      "adbusers"
      "input"
      "kvm"
      "libvirt"
      "networkmanager"
      "plugdev"
      "podman"
      "vboxusers"
      "video"
      "wheel"
      "wireshark"
    ];
    shell = pkgs.fish;
  };

  # --- Nix Configuration ---
  nix = {
    channel.enable = false;
    daemonIOSchedClass = "idle";
    daemonIOSchedPriority = 7;
    settings = {
      auto-optimise-store = true;
      builders-use-substitutes = true;
      trusted-users = ["root" "@wheel"];
      experimental-features = ["nix-command" "flakes"];
      substituters = [
        "https://mirrors.cernet.edu.cn/nix-channels/store?priority=0"
        "https://cache.nixos.org/"
      ];
      extra-substituters = [
        "https://mirror.sjtu.edu.cn/nix-channels/store"
        "https://mirrors.cernet.edu.cn/nix-channels/store"
        "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
        "https://mirrors.ustc.edu.cn/nix-channels/store"
        "https://chaotic-nyx.cachix.org/"
        "https://ezkea.cachix.org"
        "https://ghostty.cachix.org"
        "https://hyprland.cachix.org"
        "https://niri.cachix.org"
        "https://nix-community.cachix.org"
        "https://nix-gaming.cachix.org"
        "https://vicinae.cachix.org"
      ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        "ghostty.cachix.org-1:QB389yTa6gTyneehvqG58y0WnHjQOqgnA+wBnpWWxns="
        "vicinae.cachix.org-1:1kDrfienkGHPYbkpNj1mWTr7Fm1+zcenzgTizIcI3oc="
        "niri.cachix.org-1:Wv0F12uQS1m7Y38h/UbW/ptFHe4dI7oD0O4kXwQK18U="
        "chaotic-nyx.cachix.org-1:HknUhsg5I773MWCjN+GO+mpFMVrJuFvvhd7L8F1vlI8="
        "ezkea.cachix.org-1:ioBmUbJTZIKsHmWWXPe1FSFbeVe+afhfgqgTSNd34eI="
      ];
      allowed-users = ["root" "@wheel" "${username}"];
    };
  };

  # --- Boot & Kernel ---
  boot = {
    kernelPackages = pkgs.linuxPackages_zen;
    consoleLogLevel = 3;
    tmp = {
      useTmpfs = true;
      cleanOnBoot = true;
    };
    loader = {
      limine = {
        enable = true;
        efiSupport = true;
        style.wallpapers = ["/etc/nixos/wallpapers/forest_pastel.png"];
        maxGenerations = 10;
        enableEditor = true;
      };
      efi.canTouchEfiVariables = true;
    };
    supportedFilesystems = ["vfat" "ext4" "ntfs"];
    kernel.sysctl = {
      "vm.swappiness" = 20;
      "vm.dirty_writeback_centisecs" = 1500;
      "vm.dirty_ratio" = 15;
      "vm.dirty_background_ratio" = 5;
      "vm.vfs_cache_pressure" = 50;
      "power.suspend_mode" = "deep";
      "kernel.sysrq" = 0;
      "net.ipv4.icmp_ignore_bogus_error_responses" = 1;
      "net.ipv4.conf.default.rp_filter" = 1;
      "net.ipv4.conf.all.rp_filter" = 1;
      "net.ipv4.conf.all.accept_source_route" = 0;
      "net.ipv6.conf.all.accept_source_route" = 0;
      "net.ipv4.conf.all.send_redirects" = 0;
      "net.ipv4.conf.default.send_redirects" = 0;
      "net.ipv4.conf.all.accept_redirects" = 0;
      "net.ipv4.conf.default.accept_redirects" = 0;
      "net.ipv4.conf.all.secure_redirects" = 0;
      "net.ipv4.conf.default.secure_redirects" = 0;
      "net.ipv6.conf.all.accept_redirects" = 0;
      "net.ipv6.conf.default.accept_redirects" = 0;
      "net.ipv4.tcp_syncookies" = 1;
      "net.ipv4.tcp_rfc1337" = 1;
      "net.ipv4.tcp_fastopen" = 3;
      "net.ipv4.ip_forward" = 1;
      "net.ipv4.tcp_congestion_control" = "bbr";
      "net.core.default_qdisc" = "cake";
      "net.core.rmem_default" = 262144;
      "net.core.rmem_max" = 134217728;
      "net.core.wmem_default" = 262144;
      "net.core.wmem_max" = 134217728;
      "net.core.netdev_max_backlog" = 5000;
      "net.ipv4.tcp_rmem" = "4096 131072 134217728";
      "net.ipv4.tcp_wmem" = "4096 65536 134217728";
      "net.ipv4.tcp_window_scaling" = 1;
      "net.ipv4.tcp_timestamps" = 1;
      "net.ipv4.tcp_sack" = 1;
      "net.ipv4.tcp_fack" = 1;
      "net.ipv4.tcp_low_latency" = 1;
      "net.ipv4.tcp_adv_win_scale" = 1;
      "net.ipv4.tcp_tw_reuse" = 1;
      "net.ipv4.tcp_max_syn_backlog" = 8192;
    };
    kernelModules = ["tcp_bbr"];
    initrd = {
      verbose = false;
      systemd.enable = true;
    };
  };

  # --- Localization & Time ---
  time = {
    timeZone = "Asia/Shanghai";
    hardwareClockInLocalTime = true;
  };
  i18n.defaultLocale = "en_US.UTF-8";

  # --- Resource Management ---
  zramSwap = {
    enable = true;
    algorithm = "zstd";
    priority = 5;
    memoryPercent = 30;
  };

  # --- Networking ---
  networking = {
    hostName = "${host}";
    networkmanager.enable = true;
    timeServers = [
      "ntp.aliyun.com" "ntp.tencent.com" "cn.ntp.org.cn" "ntp.tuna.tsinghua.edu.cn"
      "time.apple.com" "time.windows.com" "time.cloudflare.com" "pool.ntp.org" "ntp.nict.jp"
    ];
    nameservers = ["114.114.114.114" "119.29.29.29"];
    firewall.allowedTCPPorts = [25565 53317 63080 63081 63082 63083];
  };

  # --- Security ---
  security = {
    polkit.enable = true;
    rtkit.enable = true;
    sudo-rs = {
      enable = true;
      execWheelOnly = true;
      wheelNeedsPassword = false;
    };
    pam.services.greetd.enableGnomeKeyring = true;
  };

  # --- Services ---
  services = {
    greetd = let
      session = {
        command = "${pkgs.hyprland}/bin/hyprland";
        user = username;
      };
    in {
      enable = true;
      settings = {
        terminal.vt = 1;
        default_session = session;
        initial_session = session;
      };
    };
    displayManager.autoLogin = {
      enable = true;
      user = username;
    };
    libinput.enable = true;
    gvfs.enable = true;
    tumbler.enable = true;
    udisks2.enable = true;
    fstrim.enable = true;
    openssh = {
      enable = true;
      settings = {
        PasswordAuthentication = true;
        PermitRootLogin = "no";
      };
    };
    dbus.implementation = "broker";
    psd = {
      enable = true;
      resyncTimer = "21m";
    };
    irqbalance.enable = true;
    ananicy = {
      enable = true;
      package = pkgs.ananicy-cpp;
    };
    pulseaudio.enable = false;
    pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse.enable = true;
      jack.enable = true;
      wireplumber.enable = true;
    };
    blueman.enable = true;
    printing = {
      enable = true;
      drivers = with pkgs; [gutenprint hplip splix];
    };
    geoclue2.enable = true;
    gnome.gnome-keyring.enable = true;
    avahi = {
      enable = true;
      nssmdns4 = true;
      publish = {
        enable = true;
        domain = true;
        userServices = true;
      };
    };
  };

  # --- Environment & Programs ---
  environment = {
    shells = with pkgs; [bashInteractive fish];
    systemPackages = with pkgs; [
      wget curl git pciutils usbutils dmidecode ethtool lm_sensors hdparm parted
      which killall psmisc libnotify udiskie wl-clipboard xdg-utils
      gnutar unzip zip p7zip xz zstd openssl pulseaudio networkmanagerapplet flclash clash-nyanpasu
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

  programs = {
    dconf.enable = true;
    bash.enable = true;
    fish.enable = true;
    bcc.enable = true;
    hyprland.enable = true;
    seahorse.enable = true;
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

  # --- XDG ---
  xdg.terminal-exec = {
    enable = true;
    package = pkgs.xdg-terminal-exec-mkhl;
    settings = let
      my_terminal_desktop = [
        "com.mitchellh.ghostty.desktop"
        "kitty.desktop"
        "Alacritty.desktop"
        "foot.desktop"
      ];
    in {
      Hyprland = my_terminal_desktop;
      default = my_terminal_desktop;
      GNOME = my_terminal_desktop ++ ["com.raggesilver.BlackBox.desktop" "org.gnome.Terminal.desktop"];
    };
  };
  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    config = {
      common.default = ["gtk"];
      hyprland.default = ["hyprland" "gtk"];
    };
    extraPortals = [pkgs.xdg-desktop-portal-gtk pkgs.xdg-desktop-portal-hyprland];
  };

  hardware.alsa.enablePersistence = true;
}
