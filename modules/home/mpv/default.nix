{ ... }:
{
  programs.mpv = {
    enable = true;
  };
  xdg.configFile."mpv" = {
    source = ./config;
    recursive = true;
    executable = true;
  };


}
