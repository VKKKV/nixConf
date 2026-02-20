/**
 * home/common/yazi.nix
 * Yazi: Blazing fast terminal file manager written in Rust, based on async I/O.
 */
{...}: {
  programs.yazi = {
    enable = true;
    enableBashIntegration = true;

    settings = {
      # File Manager Layout and Sorting
      mgr = {
        ratio = [1 3 4];
        sort_by = "alphabetical";
        sort_sensitive = false;
        sort_reverse = false;
        sort_dir_first = true;
        sort_translit = false;
        mouse_events = [];
        linemode = "size";
        show_hidden = false;
        show_symlink = true;
        scrolloff = 5;
        title_format = "Yazi: {cwd}";
      };

      # Preview Settings
      preview = {
        tab_size = 2;
        max_width = 600;
        max_height = 900;
        cache_dir = "";
        image_filter = "triangle";
        image_quality = 75;
        sixel_fraction = 15;
        ueberzug_scale = 1;
        ueberzug_offset = [0 0 0 0];
      };

      # Opener Definitions
      opener = {
        play = [
          {
            run = "mpv \"$@\"";
            orphan = true;
            for = "unix";
          }
        ];
        edit = [
          {
            run = "vim \"$@\"";
            block = true;
            for = "unix";
          }
        ];
      };

      # Open Rules based on MIME types
      open = {
        rules = [
          { mime = "text/*"; use = "edit"; }
          { mime = "*"; use = "edit"; }
        ];
      };
    };

    # Custom Keybindings for Plugins
    keymap = {
      mgr.prepend_keymap = [
        {
          on = "z";
          run = "plugin zoxide";
          desc = "Jump to a directory via zoxide";
        }
        {
          on = "Z";
          run = "plugin fzf";
          desc = "Jump to a file/directory via fzf";
        }
      ];
    };
  };
}
