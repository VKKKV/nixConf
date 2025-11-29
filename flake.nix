{
  description = "Retard NixOS flake";

  outputs =
    {
      self,
      nixpkgs,
      ...
    }@inputs:
    let
      username = "kita";
      system = "x86_64-linux";

      overlays = [
        # (final: prev: {
        #   rime-shuangpin-fuzhuma = prev.callPackage ./pkgs/rime-shuangpin-fuzhuma/default.nix { };
        #   rime-data = final.rime-shuangpin-fuzhuma;
        # })

        # (
        #   final: prev:
        #   withSystem prev.stdenv.hostPlatform.system (
        #     { config, ... }:
        #     {
        #       local = config.packages;
        #     }
        #   )
        # )

      ];
    in
    {
      nixosConfigurations = {
        desktop = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = {
            host = "desktop";
            inherit self inputs username;
          };
          modules = [
            ./hosts/desktop
          ];
        };

        laptop = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = {
            host = "laptop";
            inherit self inputs username;
          };
          modules = [
            ./hosts/laptop
            {
              nixpkgs.config = {
                allowUnfree = true;
                allowBroken = true;
              };
              nixpkgs.overlays = overlays;
            }
          ];
        };
      };
    };

  nixConfig = {
    # allow-import-from-derivation = true;
    substituters = [
      "https://mirrors.cernet.edu.cn/nix-channels/store?priority=0"
      "https://cache.nixos.org/"
    ];
    extra-substituters = [
      "https://nix-community.cachix.org"
      "https://nix-gaming.cachix.org"
      "https://hyprland.cachix.org"
      "https://ghostty.cachix.org"
      "https://vicinae.cachix.org"
      "https://niri.cachix.org"
      "https://chaotic-nyx.cachix.org/"
      "https://ezkea.cachix.org"
    ];

    trusted-substituters = [
      "https://mirrors.ustc.edu.cn/nix-channels/store"
      "https://mirrors.cernet.edu.cn/nix-channels/store"
      "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
      "https://mirror.sjtu.edu.cn/nix-channels/store"
      "https://cache.nixos.org"
      "https://nix-community.cachix.org"
      "https://niri.cachix.org"
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

  inputs = {
    nixpkgs.url = "git+https://mirrors.nju.edu.cn/git/nixpkgs.git?ref=nixos-unstable&shallow=1";
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";
    nix-minecraft.url = "github:Infinidoge/nix-minecraft";
    nixos-hardware.url = "github:NixOS/nixos-hardware";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.11";
    nur.url = "github:nix-community/NUR";
    vicinae.url = "github:vicinaehq/vicinae";
    nix-gaming.url = "github:fufexan/nix-gaming";

    aagl = {
      url = "github:ezKEa/aagl-gtk-on-nix/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
    quickshell = {
      url = "git+https://git.outfoxxed.me/quickshell/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    dms = {
      url = "github:AvengeMedia/DankMaterialShell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    rime = {
      url = "github:VKKKV/rime-shuangpin-fuzhuma";
      flake = false;
    };
    maple-mono = {
      url = "github:subframe7536/maple-font/variable";
      flake = false;
    };
  };
}
