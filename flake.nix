/**
* flake.nix
* The main entry point for the NixOS configuration.
* Defines inputs (nixpkgs, home-manager, etc.) and outputs (nixosConfigurations).
*/
{
  description = "NixOS Configuration Flake";

  nixConfig = {
    extra-substituters = [
      "https://cache.nixos.org/"
      "https://nix-community.cachix.org"
      "https://hyprland.cachix.org"

      "https://nix-gaming.cachix.org"
      "https://chaotic-nyx.cachix.org/"
    ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="

      "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
      "chaotic-nyx.cachix.org-1:HknUhsg5I773MWCjN+GO+mpFMVrJuFvvhd7L8F1vlI8="
    ];
  };

  outputs = {nixpkgs, ...} @ inputs: let
    vars = import ./vars;

    mkHost = import ./lib/mkHost.nix {
      inherit nixpkgs inputs vars;
    };
  in {
    formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.alejandra;

    nixosConfigurations = {
      desktop = mkHost "desktop" {
        modules = [./hosts/desktop];
      };

      # redmibook pro 15
      laptop = mkHost "laptop" {
        modules = [./hosts/laptop];
      };
    };
  };

  inputs = {
    nixpkgs.url = "git+https://mirrors.nju.edu.cn/git/nixpkgs.git?ref=nixos-unstable&shallow=1";
    nix-flatpak.url = "github:gmodena/nix-flatpak/f1f045fc8b35ff59f88982c1752d3f3a42ca6a61";
    nix-gaming.url = "github:fufexan/nix-gaming";

    aagl = {
      url = "github:ezKEa/aagl-gtk-on-nix/release-26.05";
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

    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      # If you are not running an unstable channel of nixpkgs, select the corresponding branch of Nixvim.
      # url = "github:nix-community/nixvim/nixos-26.05";

      inputs.nixpkgs.follows = "nixpkgs";
    };

    rime = {
      url = "github:VKKKV/rime-shuangpin-fuzhuma";
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
