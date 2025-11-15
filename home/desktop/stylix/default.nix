{ inputs, ...}:
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
    base16Scheme = ./color/oxocarbon-dark.yml;
    starship.enable = true;
    vesktop.enable = true;
    yazi.enable = true;
  };
}
