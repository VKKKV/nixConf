{ ... }:
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
    onlyoffice

    # System utilities
    localsend
    nix-search-tv
  ];
}
