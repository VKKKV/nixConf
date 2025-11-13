{ inputs, ... }:
{
  imports = [ inputs.vicinae.homeManagerModules.default ];

  services.vicinae = {
    enable = true;
    autoStart = true;
  };

  xdg.configFile."vicinae/vicinae.json".source = ./vicinae.json;
  xdg.configFile."vicinae/gruvbox-dark-hard.toml".source = ./gruvbox-dark-hard.toml;
}
