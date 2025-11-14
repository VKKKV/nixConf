{ host, ... }:
{
  imports =
    if (host == "laptop") then
      [
        ./core/default
        ./core/flatpak.nix
        ./core/xdg.nix
        ./home.nix
      ]
    else
      [
        ./core/default
        ./home.nix
      ];
}
