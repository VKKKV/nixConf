{
  config,
  lib,
  pkgs,
  ...
}:
  # do not need to keep too much generations
  # boot.loader.systemd-boot.configurationLimit = 10;
  # boot.loader.grub.configurationLimit = 10;

  # do garbage collection weekly to keep disk usage low
  # nix.gc = {
  #   automatic = true;
  #   dates = "weekly";
  #   options = "--delete-older-than 1w";
  # };

  # Optimise storage
  # you can also optimise the store manually via:
  #    nix-store --optimise
  # https://nixos.org/manual/nix/stable/command-ref/conf-file.html#conf-auto-optimise-store
  # nix.settings.auto-optimise-store = true;
{
  imports = [
    ./hardware-configuration.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nix";
  networking.networkmanager.enable = true;
  time.timeZone = "Asia/Tokyo";
  networking.proxy.default = "http://192.168.0.106:7897/";
  i18n.defaultLocale = "en_US.UTF-8";

  console = {
    font = "Lat2-Terminus16";
    useXkbConfig = true; # use xkb.options in tty
  };

  nix.settings.substituters = [ "https://mirror.nju.edu.cn/nix-channels/store" ];
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  users.users.root.initialHashedPassword = "";
  users.users.nix = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
    ];
  };

  programs.firefox.enable = true;

  environment.systemPackages = with pkgs; [
    git
    vim
    wget
  ];

  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  services.openssh = {
    enable = true;
    ports = [ 22 ];
    settings = {
      PasswordAuthentication = true;
      PermitRootLogin = "yes";
      AllowUsers = [ "arch" ];
    };
  };

  services.printing.enable = true;

  services.pipewire = {
    enable = true;
    pulse.enable = true;
    jack.enable = true;
  };

  services.libinput.enable = true;
  networking.firewall.enable = false;

  services.xserver = {
    enable = true;
    desktopManager.gnome.enable = true;
    displayManager.gdm.enable = true;
    xkb.layout = "us";
    xkb.options = "caps:escape";
  };

  # system.autoUpgrade.enable = true;
  # system.autoUpgrade.allowReboot = true;
  system.stateVersion = "25.11";
  system.copySystemConfiguration = true;
}
