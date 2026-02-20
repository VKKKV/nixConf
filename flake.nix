/**
 * flake.nix
 * The main entry point for the NixOS configuration.
 * Defines inputs (nixpkgs, home-manager, etc.) and outputs (nixosConfigurations).
 */
{
  description = "NixOS Configuration Flake";

  outputs = {
    self,
    nixpkgs,
    nixpkgs-stable,
    ...
  } @ inputs: let
    username = "kita";
    system = "x86_64-linux";

    pkgs-stable = import nixpkgs-stable {
      system = "x86_64-linux";
      config = {allowUnfree = true;};
    };

    overlays = [
      (final: prev: {
        inherit inputs;
        my-rime-data = prev.callPackage ./pkgs/rime-shuangpin-fuzhuma {};
      })
    ];
  in {
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

      # redmibook pro 15
      laptop = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {
          host = "laptop";
          inherit self inputs username pkgs-stable;
        };
        modules = [
          ./hosts/laptop
          {
            nixpkgs.overlays = overlays;
            nixpkgs.config.allowUnfree = true;
            nixpkgs.config.allowBroken = true;
          }
        ];
      };
    };
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
    };
    quickshell = {
      url = "git+https://git.outfoxxed.me/quickshell/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      # If you are not running an unstable channel of nixpkgs, select the corresponding branch of Nixvim.
      # url = "github:nix-community/nixvim/nixos-25.11";

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
    xmcl = {
      url = "github:x45iq/xmcl-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    mpv-config = {
      url = "github:vkkkv/mpv-config";
      flake = false;
    };
  };
}
