{ pkgs, ... }:
{
  i18n.inputMethod = {
    type = "fcitx5";
    enable = true;
    fcitx5.waylandFrontend = true;
    fcitx5.addons = with pkgs; [
      fcitx5-gtk # alternatively
      fcitx5-mozc
      fcitx5-rime

      # kdePackages.fcitx5-qt
      # fcitx5-nord # a color theme
      # fcitx5-chinese-addons
    ];
  };
}
