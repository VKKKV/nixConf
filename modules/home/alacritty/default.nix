{config, pkgs, ...}: {
  programs.alacritty = {
    enable = true;
    
    settings = {
      window.padding = {
        x = 4;
        y = 4;
      };

      env.TERM = "alacritty";

      font = {
        size = 14.0;
        normal = {
          family = "MapleMono NF CN";
          style = "Normal";
        };
        bold = {
          family = "MapleMono NF CN";
          style = "Bold";
        };
        italic = {
          family = "MapleMono NF CN";
          style = "Italic";
        };
        bold_italic = {
          family = "MapleMono NF CN";
          style = "Bold Italic";
        };
      };

      cursor = {
        style = "Block";
        blink_interval = 0;
        unfocused_hollow = true;
      };

      mouse.hide_when_typing = false;

      colors.primary.background = "#272727";

    };
  };
}