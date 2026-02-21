{host, ...}: {
  /**
   * home/common/terminals/default.nix
   * Consolidated terminal emulators and multiplexers.
   */

  # --- Ghostty Configuration ---
  programs.ghostty = {
    enable = true;
    settings = {
      theme = "Kanagawa Dragon";
      font-size = 14;
      font-family = "MapleMono NF CN";
      confirm-close-surface = false;
      window-padding-x = 4;
      window-padding-y = 4;
    };
  };

  # --- Kitty Configuration ---
  programs.kitty = {
    enable = true;
    settings = {
      confirm_os_window_close = 0;
      scrollback_lines = 10000;
      enable_audio_bell = false;
      mouse_hide_wait = 60;
      window_padding_width = if (host == "laptop") then 5 else 10;
      tab_title_template = "{index}";
      active_tab_font_style = "normal";
      inactive_tab_font_style = "normal";
      tab_bar_style = "powerline";
      tab_powerline_style = "angled";
    };
    keybindings = {
      "alt+1" = "goto_tab 1";
      "alt+2" = "goto_tab 2";
      "alt+3" = "goto_tab 3";
      "alt+4" = "goto_tab 4";
      "ctrl+shift+left" = "no_op";
      "ctrl+shift+right" = "no_op";
    };
  };

  # --- Tmux Configuration ---
  programs.tmux = {
    enable = true;
    keyMode = "vi";
    prefix = "C-SPACE";
    escapeTime = 0;
    historyLimit = 100000;
    terminal = "ghostty";
    extraConfig = ''
      unbind C-b
      set-option -g allow-passthrough on
      bind-key C-SPACE send-prefix
      set -g terminal-overrides ",ghostty:Tc"
      set-option -sa terminal-features ',xterm-256color:RGB'
      bind r source-file ~/.config/tmux/tmux.conf
      bind v split-window -h -c "#{pane_current_path}"
      bind s split-window -v -c "#{pane_current_path}"
      bind c new-window -c "#{pane_current_path}"
      bind q kill-pane
      bind ^ last-window
      bind k select-pane -U
      bind j select-pane -D
      bind h select-pane -L
      bind l select-pane -R
      bind -r n next-window
      bind -r p previous-window
      bind-key y copy-mode
      bind-key -T copy-mode-vi v send-keys -X begin-selection
      bind-key -T copy-mode-vi y send-keys -X copy-selection
      bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle
      bind-key -T copy-mode-vi Escape send-keys -X cancel
      bind-key -T copy-mode-vi Enter send-keys -X copy-selection-and-cancel
      set -g status-position top
      set -g status-justify absolute-centre
      set -g status-style 'fg=color7 bg=default'
      set -g status-right \'\'
      set -g status-left \'\'
      set -g status-left-style 'fg=color8'
      set -g status-right-length 0
      set -g status-left-length 100
      set -g status-interval 60
      setw -g window-status-current-style 'fg=colour6 bg=default bold'
      setw -g window-status-current-format '#I:#W '
      setw -g window-status-style 'fg=color8'
    '';
  };
}
