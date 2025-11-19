{ inputs, pkgs, ... }:
{
  imports = [
    inputs.stylix.nixosModules.stylix
  ];
  stylix = {
    enable = true;
    autoEnable = true;
    polarity = "dark";

    opacity = {
      popups = 1.0;
      terminal = 1.0;
    };

    base16Scheme = ./color/gruvbox-dark.yml;

    # image = ../../../gruvbox/forest_bridge.jpg;
    # image = pkgs.fetchurl {
    # url = "https://www.pixelstalk.net/wp-content/uploads/2016/05/Epic-Anime-Awesome-Wallpapers.jpg";
    # hash = "sha256-enQo3wqhgf0FEPHj2coOCvo7DuZv+x5rL/WIo4qPI50=";
    # };

    cursor.size = 24;

    fonts = {
      serif = {
        name = "Crimson Pro Font";
        package = pkgs.crimson-pro;
      };
      sansSerif = {
        name = "Barlow Font";
        package = pkgs.barlow;
      };
      monospace = {
        name = "MapleMono NF CN";
        package = pkgs.maple-mono.NF-CN-unhinted;
      };
      emoji = {
        name = "Noto Font Emoji";
        package = pkgs.noto-fonts-color-emoji;
      };
    };

    targets = {
      nixvim.enable = false;
    };
  };
}
