{
  description = "Retard NixOS flake";

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
      config = { allowUnfree = true; };
    };

    overlays = [
      # (final: prev: {
      #   rime-shuangpin-fuzhuma = prev.callPackage ./pkgs/rime-shuangpin-fuzhuma/default.nix {};
      # })
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

      laptop = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {
          host = "laptop";
          inherit self inputs username pkgs-stable;
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
