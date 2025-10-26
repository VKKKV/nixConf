if status is-interactive
    set -U fish_greeting ""
    set -gx EDITOR vim
    set -gx PATH $PATH ./node_modules/.bin $HOME/.local/bin
    alias cp='cp -r'
    alias diff="diff --color=auto"
    alias dt='date "+%Y-%m-%d %H:%M:%S"'
    alias e='exit'
    alias grep="grep --color=auto"
    alias ip="ip -color=auto"
    alias mkdir='mkdir -p'
    alias gpg='gpg --pinentry-mode loopback'
    alias ta='tmux attach; or tmux'
    alias up='paru -Syu'
    alias zathura='zathura --fork'
    alias mpvhdr='ENABLE_HDR_WSI=1 mpv --vo=gpu-next --target-colorspace-hint --gpu-api=vulkan --gpu-context=waylandvk'
    alias dd='dd bs=4M conv=fsync oflag=direct status=progress'

    starship init fish | source
    zoxide init fish | source
    atuin init fish | source

    fzf --fish | source
    set -gx FZF_DEFAULT_COMMAND 'fd --hidden'
    set -gx FZF_COMPLETION_TRIGGER '\\'
    set -gx FZF_TMUX 1
    set -gx FZF_TMUX_HEIGHT '80%'
    set -gx FZF_DEFAULT_OPTS '--preview "[[ (file --mime {}) =~ binary ]] && echo {} is a binary file || (ccat --color=always {} || highlight -O ansi -l {} || cat {}) 2> /dev/null | head -500"'
end

