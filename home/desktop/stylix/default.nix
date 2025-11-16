{ inputs, pkgs, ...}:
{
  imports = [
    inputs.stylix.homeModules.stylix
  ];

  stylix = {
    enable = true;
    autoEnable = false;
    polarity = "dark";
    opacity = {
      popups = 1.0;
      terminal = 1.0;
    };
    # base16Scheme = ./color/oxocarbon-dark.yml;
    # image = pkgs.fetchurl {
    # url = "https://www.pixelstalk.net/wp-content/uploads/2016/05/Epic-Anime-Awesome-Wallpapers.jpg";
    # hash = "sha256-enQo3wqhgf0FEPHj2coOCvo7DuZv+x5rL/WIo4qPI50=";
    # };
    image = ./gruvbox/forest_bridge.jpg;
  };
}
