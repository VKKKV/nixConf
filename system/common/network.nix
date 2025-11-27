{ pkgs, host, ... }:
{
  networking = {
    hostName = "${host}";

    networkmanager.enable = true;

    timeServers = [
      "ntp.aliyun.com" # Aliyun NTP Server
      "ntp.tencent.com" # Tencent NTP Server
      "cn.ntp.org.cn" # China NTP Pool
      "ntp.tuna.tsinghua.edu.cn" # Tsinghua University
      "time.apple.com" # Apple Global
      "time.windows.com"
      "time.cloudflare.com"
      "pool.ntp.org" # Worldwide Pool
      "ntp.nict.jp" # Japan (NICT)
    ];

    nameservers = [
      "114.114.114.114"
      "119.29.29.29"
    ];

    firewall = {
      allowedTCPPorts = [
        25565

        # localsend
        53317

        # tcp ports for testing & sharing
        63080
        63081
        63082
        63083
        63084
        63085
        63086
        63087
        63088
        63089
      ];
      allowedUDPPorts = [ ];
    };
  };

  environment.systemPackages = with pkgs; [
    networkmanagerapplet
    moonlight-qt # moonlight client, for streaming games/desktop from a PC
  ];

  programs.clash-verge = {
    enable = true;
    autoStart = true;
    tunMode = true;
    serviceMode = true;
  };

  services = {
    avahi = {
      enable = true;
      nssmdns4 = true;
      publish = {
        enable = true;
        domain = true;
        userServices = true;
      };
    };

    sunshine = {
      enable = false; # default to false, for security reasons.
      autoStart = true;
      capSysAdmin = true; # only needed for Wayland -- omit this when using with Xorg
      openFirewall = true;
      settings = {
        # pc  - Only localhost may access the web ui
        # lan - Only LAN devices may access the web ui
        origin_web_ui_allowed = "pc";
        # 2   -	encryption is mandatory and unencrypted connections are rejected
        lan_encryption_mode = 2;
        wan_encryption_mode = 2;
      };
    };
  };
}
