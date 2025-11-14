{ host, ... }:
{
  imports =
    if (host == "laptop") then
      [
        ./core/default
        ./core/flatpak.nix
        ./core/wayland.nix
        ./core/thunar.nix
        ./home.nix
      ]
    else
      [
        ./core/default
        ./home.nix
      ];
}
