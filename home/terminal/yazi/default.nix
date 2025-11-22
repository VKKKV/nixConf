{ ... }:
{
  programs.yazi = {
    enable = true;
    enableBashIntegration = true;
    enableFishIntegration = true;
    enableZshIntegration = true;
    
    settings = {
      mgr = {
        ratio = [ 1 3 4 ];
        sort_by = "alphabetical";
        sort_sensitive = false;
        sort_reverse = false;
        sort_dir_first = true;
        sort_translit = false;
        mouse_events = [ ];
        linemode = "size";
        show_hidden = false;
        show_symlink = true;
        scrolloff = 5;
        title_format = "Yazi: {cwd}";
      };
      
      preview = {
        tab_size = 2;
        max_width = 600;
        max_height = 900;
        cache_dir = "";
        image_filter = "triangle";
        image_quality = 75;
        sixel_fraction = 15;
        ueberzug_scale = 1;
        ueberzug_offset = [ 0 0 0 0 ];
      };
      
      opener = {
        play = [
          { run = "mpv \"$@\""; orphan = true; for = "unix"; }
        ];
        edit = [
          { run = "vim \"$@\""; block = true; for = "unix"; }
        ];
      };
      
      open = {
        rules = [
          { mime = "text/*"; use = "edit"; }
          { mime = "*"; use = "edit"; }
        ];
      };
    };
    
    keymap = {
      manager.prepend_keymap = [
        { on = "z"; run = "plugin zoxide"; desc = "Jump to a directory via zoxide"; }
        { on = "Z"; run = "plugin fzf"; desc = "Jump to a file/directory via fzf"; }
      ];
    };
    
    theme = {
      flavor.use = "kanagawa";
    };
  };

  # Keep the flavor directory for the kanagawa theme
  xdg.configFile."yazi/flavors/kanagawa.yazi" = {
    source = ./config/flavors/kanagawa.yazi;
    recursive = true;
  };
}