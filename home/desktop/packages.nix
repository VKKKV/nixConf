{ pkgs, ... }:
{
  home.packages = with pkgs; [
    pavucontrol
    pwvucontrol
    localsend
    # onlyoffice-bin
  ];
}
