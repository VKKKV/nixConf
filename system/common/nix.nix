{...}: {
  nix = {
    channel.enable = false; # remove nix-channel related tools & configs, we use flakes instead.

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
      ];

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

      trusted-substituters = [
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
    };
  };
}
