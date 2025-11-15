{ pkgs, host, ... }:
{
  networking = {
    hostName = "${host}";

    networkmanager.enable = true;

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

  # network discovery
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    publish = {
      enable = true;
      domain = true;
      userServices = true;
    };
  };
}
