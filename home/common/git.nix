/**
 * home/common/git.nix
 * Git version control configuration.
 * Includes settings for Git, Lazygit, GitHub CLI (gh), and Delta (diff viewer).
 */
{...}: {
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "vkkkv";
        email = "vkkkv@example.com";
      };
      init.defaultBranch = "main";
      diff.colorMoved = "default";
      color.ui = true;
    };
  };

  # Lazygit: Simple terminal UI for git commands
  programs.lazygit = {
    enable = true;
    settings = {
      gui.border = "single";
    };
  };

  # GitHub CLI (gh) configuration
  programs.gh = {
    enable = true;
    settings = {
      git_protocol = "ssh";
      prompt = "enabled";
    };
    hosts = {
      "github.com" = {
        "users" = {
          "vkkkv" = null;
        };
        "user" = "vkkkv";
      };
    };
  };

  # Delta: Syntax-highlighting pager for git, diff, and grep output
  programs.delta = {
    enable = true;
    enableGitIntegration = true;
    options = {
      line-numbers = true;
      side-by-side = false;
      diff-so-fancy = true;
      navigate = true;
    };
  };

  # Global git ignore configuration
  xdg.configFile."git/.gitignore".text = ''
    .vscode
    .idea
  '';
}
