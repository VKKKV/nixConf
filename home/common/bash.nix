{...}: {
  programs.bash = {
    enable = true;
    enableCompletion = true;

    # https://bash-prompt-generator.org/
    initExtra = ''
      export PS1='\[\e[38;5;76m\]\u\[\e[0m\] in \[\e[38;5;32m\]\w\[\e[0m\] \\$ '
    '';

    bashrcExtra = ''
      export PATH="$PATH:$HOME/bin:$HOME/.local/bin:$HOME/go/bin"
    '';
    shellAliases = {
      e = "exit";
    };
  };
}
