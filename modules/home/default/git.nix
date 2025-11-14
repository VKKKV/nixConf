{ pkgs, ... }:
{
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

  home.packages = [ pkgs.gh ];

  xdg.configFile."git/.gitignore".text = ''
    .vscode
    .idea
  '';

  programs.zsh.shellAliases = {
    g = "lazygit";
    gf = "onefetch --number-of-file-churns 0 --no-color-palette";

    gs = "git status";
    gcl = "git clone";
    gd = "git diff";

    ga = "git add";
    gaa = "git add --all";

    gc = "git commit";
    gcm = "git commit -m";

    gpl = "git pull";
    gplo = "git pull origin";

    gps = "git push";
    gpso = "git push origin";
    gpst = "git push --tags";
    gtag = "git tag -ma";

    gm = "git merge";
    gb = "git branch";
    gch = "git checkout";
    gchb = "git checkout -b";

    glog = "git log --oneline --decorate --graph";
    glol = "git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset'";
    glola = "git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset' --all";
    glols = "git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset' --stat";
  };
}
