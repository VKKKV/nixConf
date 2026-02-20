/**
 * home/common/tmux.nix
 * Tmux: Terminal multiplexer.
 * Custom configuration with Vi keybindings and optimized status bar.
 */
{...}: {
  programs.tmux = {
    enable = true;
    keyMode = "vi";
    prefix = "C-SPACE";
    escapeTime = 0;
    historyLimit = 100000;

    # Terminal settings optimized for Ghostty/Kitty
    terminal = "ghostty";
    extraConfig = ''
      unbind C-b
      set-option -g allow-passthrough on
      bind-key C-SPACE send-prefix
      set -g terminal-overrides ",ghostty:Tc"
      set-option -sa terminal-features ',xterm-256color:RGB'

      # Configuration reloading
      bind r source-file ~/.config/tmux/tmux.conf

      # Pane/Window management
      bind v split-window -h -c "#{pane_current_path}"
      bind s split-window -v -c "#{pane_current_path}"
      bind c new-window -c "#{pane_current_path}"
      bind q kill-pane
      bind ^ last-window
      
      # Vim-like pane navigation
      bind k select-pane -U
      bind j select-pane -D
      bind h select-pane -L
      bind l select-pane -R
      
      # Window navigation
      bind -r n next-window
      bind -r p previous-window

      # Copy mode (Vi style)
      bind-key y copy-mode
      bind-key -T copy-mode-vi v send-keys -X begin-selection
      bind-key -T copy-mode-vi y send-keys -X copy-selection
      bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle
      bind-key -T copy-mode-vi Escape send-keys -X cancel
      bind-key -T copy-mode-vi Enter send-keys -X copy-selection-and-cancel

      # Minimalist Status Bar
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
