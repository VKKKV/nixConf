/**
 * system/common/network.nix
 * Networking configuration shared across all hosts.
 * Includes host identification, NTP servers, firewall settings, and network-related services.
 */
{
  pkgs,
  host,
  ...
}: {
  networking = {
    hostName = "${host}";

    # Use NetworkManager for network connection management
    networkmanager.enable = true;

    # Optimized NTP servers for China and global connectivity
    timeServers = [
      "ntp.aliyun.com"
      "ntp.tencent.com"
      "cn.ntp.org.cn"
      "ntp.tuna.tsinghua.edu.cn"
      "time.apple.com"
      "time.windows.com"
      "time.cloudflare.com"
      "pool.ntp.org"
      "ntp.nict.jp"
    ];

    # Primary DNS nameservers
    nameservers = [
      "114.114.114.114"
      "119.29.29.29"
    ];

    # Firewall configuration with specific port allowances
    firewall = {
      allowedTCPPorts = [
        25565 # Minecraft

        # localsend
        53317

        # Testing & Sharing ports
        63080
        63081
        63082
        63083
      ];
      allowedUDPPorts = [];
    };
  };

  # Network-related system packages
  environment.systemPackages = with pkgs; [
    networkmanagerapplet
    flclash
    clash-nyanpasu
  ];

  services = {
    # Avahi/mDNS for local network discovery
    avahi = {
      enable = true;
      nssmdns4 = true;
      publish = {
        enable = true;
        domain = true;
        userServices = true;
      };
    };

    # Sunshine: Game streaming host for Moonlight (disabled by default)
    sunshine = {
      enable = false;
      autoStart = true;
      capSysAdmin = true;
      openFirewall = true;
      settings = {
        origin_web_ui_allowed = "pc";
        lan_encryption_mode = 2;
        wan_encryption_mode = 2;
      };
    };
  };
}
