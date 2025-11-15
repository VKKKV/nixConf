{pkgs, ...}:
{
  # Boot configuration
  boot = {
    kernelPackages = pkgs.linuxPackages_zen;
    consoleLogLevel = 3;
    kernelParams = [
      "quiet"
      "systemd.show_status=auto"
      "rd.udev.log_level=3"
      "plymouth.use-simpledrm"
    ];

    plymouth.enable = true;

    tmp = {
      useTmpfs = true;
      cleanOnBoot = true;
    };

    loader = {
      limine = {
        enable = true;
        efiSupport = true;
        style.wallpapers = [
          "/etc/nixos/wallpapers/otherWallpaper/gruvbox/forest_pastel.png"
        ];
        maxGenerations = 10;
        enableEditor = true;
        extraConfig = ''
          /Windows
          protocol: efi
          path: boot():/EFI/Microsoft/Boot/bootmgfw.efi
        '';
      };
      # systemd-boot = {
      #   enable = true;
      #   configurationLimit = 10;
      # };
      efi.canTouchEfiVariables = true;
    };

    supportedFilesystems = [
      "vfat"
      "ext4"
      "ntfs"
    ];

      # Optimize system parameters
      kernel.sysctl = {
        "vm.swappiness" = 20;           # Reduce swap aggressiveness
        "vm.dirty_writeback_centisecs" = 1500;  # Longer writeback intervals
        "power.suspend_mode" = "deep";         # Better suspend state

        # The Magic SysRq key is a key combo that allows users connected to the
        # system console of a Linux kernel to perform some low-level commands.

        ## TCP hardening
        # Prevent bogus ICMP errors from filling up logs.
        "net.ipv4.icmp_ignore_bogus_error_responses" = 1;
        # Reverse path filtering causes the kernel to do source validation of
        # packets received from all interfaces. This can mitigate IP spoofing.
        "net.ipv4.conf.default.rp_filter" = 1;
        "net.ipv4.conf.all.rp_filter" = 1;
        # Do not accept IP source route packets (we're not a router)
        "net.ipv4.conf.all.accept_source_route" = 0;
        "net.ipv6.conf.all.accept_source_route" = 0;
        # Don't send ICMP redirects (again, we're not a router)
        "net.ipv4.conf.all.send_redirects" = 0;
        "net.ipv4.conf.default.send_redirects" = 0;
        # Refuse ICMP redirects (MITM mitigations)
        "net.ipv4.conf.all.accept_redirects" = 0;
        "net.ipv4.conf.default.accept_redirects" = 0;
        "net.ipv4.conf.all.secure_redirects" = 0;
        "net.ipv4.conf.default.secure_redirects" = 0;
        "net.ipv6.conf.all.accept_redirects" = 0;
        "net.ipv6.conf.default.accept_redirects" = 0;
        # Protects against SYN flood attacks
        "net.ipv4.tcp_syncookies" = 1;
        # Incomplete protection again TIME-WAIT assassination
        "net.ipv4.tcp_rfc1337" = 1;

        ## TCP optimization
        # TCP Fast Open is a TCP extension that reduces network latency by packing
        # data in the sender’s initial TCP SYN. Setting 3 = enable TCP Fast Open for
        # both incoming and outgoing connections:
        "net.ipv4.tcp_fastopen" = 3;

        # Enable IPv4 forwarding for VPN/container routing
        "net.ipv4.ip_forward" = 1;
        # Bufferbloat mitigations + slight improvement in throughput & latency
        "net.ipv4.tcp_congestion_control" = "bbr";
        "net.core.default_qdisc" = "cake";

        ## Network performance optimizations
        # Increase network buffer sizes
        "net.core.rmem_default" = 262144;
        "net.core.rmem_max" = 134217728;
        "net.core.wmem_default" = 262144;
        "net.core.wmem_max" = 134217728;

        # TCP buffer sizes
        "net.ipv4.tcp_rmem" = "4096 131072 134217728";
        "net.ipv4.tcp_wmem" = "4096 65536 134217728";

        # TCP performance
        "net.ipv4.tcp_window_scaling" = 1;
        "net.ipv4.tcp_timestamps" = 1;
        "net.ipv4.tcp_sack" = 1;
        "net.ipv4.tcp_fack" = 1;
        "net.ipv4.tcp_low_latency" = 1;
        "net.ipv4.tcp_adv_win_scale" = 1;

        # Reduce TIME_WAIT sockets
        "net.ipv4.tcp_fin_timeout" = 15;
        "net.ipv4.tcp_tw_reuse" = 1;
      };

      kernelModules = ["tcp_bbr"];
    };
}
