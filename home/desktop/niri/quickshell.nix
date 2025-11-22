{
  pkgs,
  inputs,
  ...
}:
let
  quickshell = inputs.quickshell.packages.${pkgs.system}.default;
in
{
  home.packages =
    with pkgs;
    [
      quickshell
    ]
    ++ [
      accountsservice
      adw-gtk3
      brightnessctl
      cava
      cliphist
      ddcutil
      elogind
      glib
      inputs.dms.packages.${pkgs.system}.default
      kdePackages.qt6ct
      kdePackages.qtmultimedia
      khal
      libsForQt5.qt5ct
      material-symbols
      matugen
      swww
      wl-clipboard
    ];
}
