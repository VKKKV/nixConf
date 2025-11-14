{ host, ... }:
{
  imports =
    if (host == "laptop") then
      [
        ./core/default
        ./core/flatpak.nix
        ./core/wayland.nix
        ./home.nix
      ]
    else
      [
        ./core/default
        ./home.nix
      ];
}
