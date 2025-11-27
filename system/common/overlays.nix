{
  pkgs,
  inputs,
  ...
}@args:
{
  imports = [
    inputs.nix-minecraft.nixosModules.minecraft-servers
  ];

  nixpkgs.overlays = [
    inputs.nur.overlays.default
    inputs.nix-minecraft.overlay
  ]
  ++ (import ../../overlays args);
}
