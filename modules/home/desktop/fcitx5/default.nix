{ pkgs, ... }:
{
  i18n.inputMethod = {
    type = "fcitx5";
    enable = true;
    fcitx5.waylandFrontend = true;
    fcitx5.addons = with pkgs; [
      fcitx5-gtk
      fcitx5-mozc

      # https://github.com/gaboolic/rime-shuangpin-fuzhuma
      fcitx5-rime

      # theme
      fcitx5-mellow-themes
    ];
  };
}
