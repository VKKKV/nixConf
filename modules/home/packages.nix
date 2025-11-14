{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # Multimedia
    audacity
    gimp
    obs-studio
    pavucontrol
    pwvucontrol
    soundwireserver

    # Office
    # onlyoffice-bin

    # System utilities
    localsend
    # nix-search-tv
  ];
}
