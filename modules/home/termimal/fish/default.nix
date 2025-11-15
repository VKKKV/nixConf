{ ... }:
{
  programs.fish = {
    enable = true;

    interactiveShellInit = ''
      set -U fish_greeting ""
    '';

    shellAliases = {
     cp = "cp -r";
     diff = "diff --color=auto";
     dt = "date \"+%Y-%m-%d %H:%M:%S\"";
     e = "exit";
     grep = "grep --color=auto";
     ip = "ip -color=auto";
     mkdir = "mkdir -p";
     gpg = "gpg --pinentry-mode loopback";
     ta = "tmux attach; or tmux";
     up = "paru -Syu";
     zathura = "zathura --fork";
     mpvhdr = "ENABLE_HDR_WSI=1 mpv --vo=gpu-next --target-colorspace-hint --gpu-api=vulkan --gpu-context=waylandvk";
     dd = "dd bs=4M conv=fsync oflag=direct status=progress";
    };
  };
}
