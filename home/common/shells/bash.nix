{...}: {
  /**
   * home/common/bash.nix
   * Shared user-level Bash shell configuration.
   */

  programs.bash = {
    enable = true;
    enableCompletion = true;

    # Custom shell prompt configuration
    # Generated from: https://bash-prompt-generator.org/
    initExtra = ''
      export PS1='\[\e[38;5;76m\]\u\[\e[0m\] in \[\e[38;5;32m\]\w\[\e[0m\] \\$ '
    '';

    # Additional bashrc configuration
    # Includes local binary paths in the system PATH
    bashrcExtra = ''
      export PATH="$PATH:$HOME/bin:$HOME/.local/bin:$HOME/go/bin"
    '';

    # Bash-specific shell aliases
    shellAliases = {
      e = "exit";
    };
  };
}
