{ host, ... }:
{
  imports =
    if (host == "laptop") then
      [
        ./core/default
        ./home.nix

        ./core/fonts.nix
        # ./core/flatpak.nix
        # ./core/xdg.nix
      ]
    else
      [
        ./core/default
        ./home.nix
      ];
}
