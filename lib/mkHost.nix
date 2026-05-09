# lib/mkHost.nix
# 统一 nixosSystem 调用的工厂函数，确保所有 host 共享相同的 overlays、allowUnfree 等配置。
{
  nixpkgs,
  nixpkgs-stable,
  inputs,
  self,
  vars,
}: let
  pkgs-stable = import nixpkgs-stable {
    system = vars.system;
    config.allowUnfree = true;
  };

  overlays = [
    (final: prev: {
      inherit inputs;
      my-rime-data = prev.callPackage ../pkgs/rime-shuangpin-fuzhuma {};
    })
  ];
in
  host:
    { modules ? [] }:
      nixpkgs.lib.nixosSystem {
        system = vars.system;
        specialArgs = {
          inherit self inputs pkgs-stable;
          host = host;
          username = vars.username;
        };
        modules =
          modules
          ++ [
            {
              nixpkgs.overlays = overlays;
              nixpkgs.config.allowUnfree = true;
            }
          ];
      }
