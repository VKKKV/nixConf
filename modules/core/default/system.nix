{ pkgs, ... }:
{
  nix = {
    settings = {
      auto-optimise-store = true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      substituters = [
        "https://mirrors.ustc.edu.cn/nix-channels/store"
        "https://cache.nixos.org/"
        "https://nix-community.cachix.org"
        "https://nix-gaming.cachix.org"
        "https://hyprland.cachix.org"
        "https://ghostty.cachix.org"
        "https://vicinae.cachix.org"
      ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        "ghostty.cachix.org-1:QB389yTa6gTyneehvqG58y0WnHjQOqgnA+wBnpWWxns="
        "vicinae.cachix.org-1:1kDrfienkGHPYbkpNj1mWTr7Fm1+zcenzgTizIcI3oc="
      ];
    };
  };

  environment.variables.EDITOR = "vim";
  environment.systemPackages = with pkgs; [
    wget
    git
    vim
  ];

  time = {
    timeZone = lib.mkDefault "Asia/Tokyo";
    hardwareClockInLocalTime = lib.mkDefault true;
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

  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 25;
  };

  nixpkgs = {
    config.allowUnfree = true;
    config.permittedInsecurePackages = [
      "electron-25.9.0"
  ];
}
