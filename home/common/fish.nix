{...}: {
  /**
   * home/common/fish.nix
   * Shared user-level Fish shell configuration.
   */

  programs.fish = {
    enable = true;

    # Disable the default greeting message
    interactiveShellInit = ''
      set fish_greeting
    '';

    # Fish shell aliases
    shellAliases = {
      # Basic commands
      cp = "cp -r";
      diff = "diff --color=auto";
      grep = "grep --color=auto";
      ip = "ip -color=auto";
      dt = "date \"+%Y-%m-%d %H:%M:%S\"";
      e = "exit";

      # Utility & Custom
      y = "yy";
      ta = "tmux attach; or tmux";
      zathura = "zathura --fork";

      # MPV with HDR support
      mpvhdr = "ENABLE_HDR_WSI=1 mpv --vo=gpu-next --target-colorspace-hint --gpu-api=vulkan --gpu-context=waylandvk";
    };
  };
}
