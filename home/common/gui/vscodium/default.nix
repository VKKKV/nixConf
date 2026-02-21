{pkgs, ...}: let
  jonathanharty-gruvbox-material-icon-theme = pkgs.vscode-utils.buildVscodeMarketplaceExtension {
    mktplcRef = {
      name = "gruvbox-material-icon-theme";
      publisher = "JonathanHarty";
      version = "1.1.5";
      hash = "sha256-86UWUuWKT6adx4hw4OJw3cSZxWZKLH4uLTO+Ssg75gY=";
    };
  };
in {
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    profiles.default = {
      extensions =
        (with pkgs.vscode-extensions; [
          bbenoist.nix
          continue.continue
          davidanson.vscode-markdownlint
          eamodio.gitlens
          formulahendry.code-runner
          foxundermoon.shell-format
          hediet.vscode-drawio
          usernamehw.errorlens
          vscodevim.vim
          yzhang.markdown-all-in-one
          arrterian.nix-env-selector
          golang.go
          jnoortheen.nix-ide
          llvm-vs-code-extensions.vscode-clangd
          ms-python.debugpy
          ms-python.python
          rust-lang.rust-analyzer
          tamasfe.even-better-toml
          ziglang.vscode-zig
          ms-azuretools.vscode-containers
          ms-azuretools.vscode-docker
          vadimcn.vscode-lldb
          jdinhlife.gruvbox
          pkief.material-icon-theme
        ])
        ++ [
          jonathanharty-gruvbox-material-icon-theme
        ];

      keybindings = [];

      userSettings = {
        "nix.formatterPath" = "nixfmt";
        "editor.lineNumbers" = "relative";
        "editor.fontVariations" = true;
        "editor.renderWhitespace" = "all";
        "editor.rulers" = [80];
        "editor.wordWrapColumn" = 80;
        "editor.formatOnSave" = true;
        "editor.cursorBlinking" = "solid";
        "files.encoding" = "utf8";
        "files.autoSave" = "afterDelay";
        "diffEditor.ignoreTrimWhitespace" = true;

        "telemetry.telemetryLevel" = "off";
        "update.mode" = "none";
        "git.enableSmartCommit" = false;
        "github.gitAuthentication" = false;
        "workbench.settings.enableNaturalLanguageSearch" = false;
        "workbench.enableExperiments" = false;

        "extensions.autoCheckUpdates" = false;
        "extensions.autoUpdate" = false;
        "extensions.ignoreRecommendations" = true;

        "workbench.secondarySideBar.defaultVisibility" = "hidden";
        "explorer.confirmDelete" = false;
        "explorer.confirmDragAndDrop" = false;
        "workbench.tree.indent" = 12;

        "git.confirmSync" = false;
        "git.ignoreRebaseWarning" = true;
        "gitlens.ai.model" = "gitkraken";
        "gitlens.ai.vscode.model" = "copilot:gpt-4.1";
        "gitlens.ai.gitkraken.model" = "gemini:gemini-2.0-flash";
        "gitlens.views.scm.grouped.views" = {
          commits = true;
          branches = true;
          remotes = true;
          stashes = true;
          tags = true;
          worktrees = true;
          contributors = true;
          fileHistory = false;
          repositories = true;
          searchAndCompare = false;
          launchpad = true;
        };

        "vim.leader" = " ";
        "vim.easymotion" = true;
        "vim.surround" = true;
        "vim.useSystemClipboard" = true;
        "vim.incsearch" = true;
        "vim.hlsearch" = true;
        "vim.ignorecase" = true;
        "vim.normalModeKeyBindings" = [
          {before = ["<Leader>" "q"]; commands = [":q!"];}
          {before = ["<Leader>" "p"]; commands = [":bprevious"];}
          {before = ["<Leader>" "n"]; commands = [":bnext"];}
          {before = ["<Leader>" "x"]; commands = [":bd"];}
          {before = ["<Leader>" "f"]; commands = ["editor.action.formatDocument"];}
          {before = ["<Leader>" "t" "n"]; commands = ["workbench.action.nextEditor"];}
          {before = ["<Leader>" "t" "p"]; commands = ["workbench.action.previousEditor"];}
          {before = ["<Leader>" "t" "c"]; commands = ["workbench.action.newEditor"];}
          {before = ["<Leader>" "v"]; commands = ["workbench.action.splitEditorRight"];}
          {before = ["<Leader>" "s"]; commands = ["workbench.action.splitEditorDown"];}
          {before = ["<Leader>" "h"]; commands = ["workbench.action.navigateLeft"];}
          {before = ["<Leader>" "j"]; commands = ["workbench.action.navigateDown"];}
          {before = ["<Leader>" "k"]; commands = ["workbench.action.navigateUp"];}
          {before = ["<Leader>" "l"]; commands = ["workbench.action.navigateRight"];}
          {before = ["<Leader>" "e"]; commands = ["workbench.files.action.focusFilesExplorer"];}
        ];

        "vim.handleKeys" = {
          "<C-a>" = false;
          "<C-f>" = false;
          "<C-d>" = false;
          "<C-b>" = false;
          "<C-c>" = false;
        };

        "vim.statusBarColors.normal" = ["#1d2021" "#a89984"];
        "vim.statusBarColors.insert" = ["#1d2021" "#689d6a"];
        "vim.statusBarColors.visual" = ["#1d2021" "#b16286"];
        "vim.statusBarColors.visualline" = ["#1d2021" "#b16286"];
        "vim.statusBarColors.visualblock" = ["#1d2021" "#d79921"];
        "vim.statusBarColors.replace" = ["#1d2021" "#d65d0e"];

        "tabnine.experimentalAutoImports" = true;
      };
    };
  };
}
