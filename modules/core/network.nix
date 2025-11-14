{ pkgs, host, ... }:
{
  networking = {
    # proxy.default = "http://192.168.0.106:7897/";

    hostName = "${host}";
    networkmanager.enable = true;
    # networkmanager.wifi.powersave = true;

    hosts = {
      "20.205.243.166" = [
        "github.com"
        "raw.githubusercontent.com"
      ];
    };

    nameservers = [
      "114.114.114.114"
      "119.29.29.29"
    ];

    firewall = {
      enable = false;
      allowedTCPPorts = [
        22
        80
        443
        25565
      ];

      allowedUDPPorts = [ 25565 ];
    };
  };

  environment.systemPackages = with pkgs; [
    networkmanagerapplet
  ];

  programs.clash-verge = {
    enable = true;
    tunMode = true;
    serviceMode = true;
  };
}
