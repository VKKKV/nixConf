/**
 * home/common/kitty.nix
 * Kitty: A fast, feature-rich, GPU-based terminal emulator.
 */
{host, ...}: {
  programs.kitty = {
    enable = true;

    settings = {
      confirm_os_window_close = 0;
      scrollback_lines = 10000;
      enable_audio_bell = false;
      mouse_hide_wait = 60;

      # Adjust window padding based on host type
      window_padding_width =
        if (host == "laptop")
        then 5
        else 10;

      # Tab Bar Configuration
      tab_title_template = "{index}";
      active_tab_font_style = "normal";
      inactive_tab_font_style = "normal";
      tab_bar_style = "powerline";
      tab_powerline_style = "angled";
    };

    # Custom Keybindings
    keybindings = {
      # Fast tab switching
      "alt+1" = "goto_tab 1";
      "alt+2" = "goto_tab 2";
      "alt+3" = "goto_tab 3";
      "alt+4" = "goto_tab 4";

      # Disable default arrow-key tab switching to avoid conflicts
      "ctrl+shift+left" = "no_op";
      "ctrl+shift+right" = "no_op";
    };
  };
}
