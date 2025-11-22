{ ... }:
{
  programs.fish = {
    enable = true;

    interactiveShellInit = ''
      set -U fish_greeting ""

      # Performance optimization: Disable greeting and reduce startup time
      set -g fish_prompt_delay 0

      # Better command completions
      set -g fish_autosuggestion_enabled true
      set -g fish_color_autosuggestion brblack

      # Reduce key repeat delay
      set -g fish_sequence_timeout 100
    '';

    shellAliases = {
      # File operations
     cp = "cp -r";

      # System utilities
      diff = "diff --color=auto";
      grep = "grep --color=auto";
      ip = "ip -color=auto";

      # Date and time
      dt = "date \"+%Y-%m-%d %H:%M:%S\"";

      # Quick commands
      e = "exit";

      # GPG with proper pinentry
      gpg = "gpg --pinentry-mode loopback";

      # Tmux shortcuts
      ta = "tmux attach; or tmux";

      # PDF viewer
      zathura = "zathura --fork";

      # HDR video player
      mpvhdr = "ENABLE_HDR_WSI=1 mpv --vo=gpu-next --target-colorspace-hint --gpu-api=vulkan --gpu-context=waylandvk";
    };
  };
}