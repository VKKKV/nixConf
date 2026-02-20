/**
 * system/common/boot.nix
 * Bootloader, kernel, and low-level system performance/security optimizations.
 */
{pkgs, ...}: {
  boot = {
    # Use the Zen kernel for better desktop responsiveness
    kernelPackages = pkgs.linuxPackages_zen;

    consoleLogLevel = 3;
    kernelParams = [];

    # Use tmpfs for /tmp for faster I/O and automatic cleanup on reboot
    tmp = {
      useTmpfs = true;
      cleanOnBoot = true;
    };

    # Limine bootloader configuration
    loader = {
      limine = {
        enable = true;
        efiSupport = true;
        style.wallpapers = [
          "/etc/nixos/wallpapers/forest_pastel.png"
        ];
        maxGenerations = 10;
        enableEditor = true;
      };
      efi.canTouchEfiVariables = true;
    };

    supportedFilesystems = [
      "vfat"
      "ext4"
      "ntfs"
    ];

    # --- Kernel & Network Optimizations ---
    kernel.sysctl = {
      # Memory management
      "vm.swappiness" = 20;
      "vm.dirty_writeback_centisecs" = 1500;
      "vm.dirty_ratio" = 15;
      "vm.dirty_background_ratio" = 5;
      "vm.vfs_cache_pressure" = 50;
      "power.suspend_mode" = "deep";

      # Security: Disable Magic SysRq
      "kernel.sysrq" = 0;

      # TCP Hardening & Security
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

      # TCP Performance & Latency
      "net.ipv4.tcp_fastopen" = 3;
      "net.ipv4.ip_forward" = 1;
      "net.ipv4.tcp_congestion_control" = "bbr";
      "net.core.default_qdisc" = "cake";

      # Network Buffer Optimizations
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

    # Boot performance improvements
    initrd = {
      verbose = false;
      systemd.enable = true;
    };
  };
}
