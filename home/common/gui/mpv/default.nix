{inputs, ...}: {
  programs.mpv = {
    enable = true;
  };
  xdg.configFile."mpv" = {
    source = inputs.mpv-config;
    recursive = true;
    executable = true;
  };
}
