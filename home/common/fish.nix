{ ... }:
{
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting
    '';
    shellAliases = {
      cp = "cp -r";
      diff = "diff --color=auto";
      grep = "grep --color=auto";
      ip = "ip -color=auto";
      dt = "date \"+%Y-%m-%d %H:%M:%S\"";
      e = "exit";
      ta = "tmux attach; or tmux";
      zathura = "zathura --fork";
      mpvhdr = "ENABLE_HDR_WSI=1 mpv --vo=gpu-next --target-colorspace-hint --gpu-api=vulkan --gpu-context=waylandvk";
    };
  };
}
