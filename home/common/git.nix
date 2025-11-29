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
      # merge.conflictstyle = "diff3";
      # pull.ff = "only";
    };
  };

  programs.lazygit = {
    enable = true;

    settings = {
      gui.border = "single";
    };
  };

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

  xdg.configFile."git/.gitignore".text = ''
    .vscode
    .idea
  '';
}
