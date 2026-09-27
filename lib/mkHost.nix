# lib/mkHost.nix
# 统一 nixosSystem 调用的工厂函数，确保所有 host 共享相同的 overlays、allowUnfree 等配置。
{
  nixpkgs,
  inputs,
  vars,
}: let
  overlays = [
    (final: prev: {
      my-rime-data = prev.callPackage ../pkgs/rime-shuangpin-fuzhuma {inherit inputs;};
    })
  ];
in
  host: {modules ? []}:
    nixpkgs.lib.nixosSystem {
      system = vars.system;
      specialArgs = {
        inherit inputs;
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
