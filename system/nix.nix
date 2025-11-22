{ pkgs, lib, ... }:
{
  nix = {
    # Enable both the daemon and auto-optimization for better performance
    daemonIOSchedClass = "idle";
    daemonIOSchedPriority = 7;
    settings = {
      auto-optimise-store = true;
      builders-use-substitutes = true;
      trusted-users = [
        "root"
        "@wheel"
      ];
      experimental-features = [
        "nix-command"
        "flakes"
        "auto-allocate-uids"
        "ca-derivations"
      ];

      substituters = [
        "https://mirrors.ustc.edu.cn/nix-channels/store"
        "https://cache.nixos.org/"

        "https://nix-community.cachix.org"
        "https://nix-gaming.cachix.org"
        "https://hyprland.cachix.org"
        "https://ghostty.cachix.org"
        "https://vicinae.cachix.org"
        "https://niri.cachix.org"
        "https://chaotic-nyx.cachix.org/"
      ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        "ghostty.cachix.org-1:QB389yTa6gTyneehvqG58y0WnHjQOqgnA+wBnpWWxns="
        "vicinae.cachix.org-1:1kDrfienkGHPYbkpNj1mWTr7Fm1+zcenzgTizIcI3oc="
        "niri.cachix.org-1:Wv0F12uQS1m7Y38h/UbW/ptFHe4dI7oD0O4kXwQK18U="
        "chaotic-nyx.cachix.org-1:HknUhsg5I773MWCjN+GO+mpFMVrJuFvvhd7L8F1vlI8="
      ];
    };
  };

  nixpkgs = {
    config.allowUnfree = true;
    config.permittedInsecurePackages = [
      "electron-25.9.0"
      "electron-36.9.5"
    ];
  };

  # nix helper
  programs.nh = {
    enable = true;
    # weekly cleanup
    clean = {
      enable = true;
      extraArgs = "--keep-since 7d --keep 3";
    };
    flake = "/home/kita/nixos"; # sets NH_OS_FLAKE variable for you
  };
}

