{ ... }:
{
  programs.vscode.profiles.default = {
    userSettings = {
      "nix.formatterPath" = "nixfmt";
      "editor.lineNumbers" = "relative";
      "editor.fontVariations" = true;
      "editor.renderWhitespace" = "all";
      "editor.rulers" = [ 80 ];
      "editor.wordWrapColumn" = 80;
      "editor.formatOnSave" = true;
      "editor.cursorBlinking" = "solid";
      "files.encoding" = "utf8";
      "files.autoSave" = "afterDelay";
      "diffEditor.ignoreTrimWhitespace" = true;

      #----- Privacy & Security -----
      "telemetry.telemetryLevel" = "off";
      "update.mode" = "none";
      "git.enableSmartCommit" = false;
      "github.gitAuthentication" = false;
      "workbench.settings.enableNaturalLanguageSearch" = false;
      "workbench.enableExperiments" = false;

      #----- Extension Management -----
      "extensions.autoCheckUpdates" = false;
      "extensions.autoUpdate" = false;
      "extensions.ignoreRecommendations" = true;

      #----- File Explorer -----
      "workbench.secondarySideBar.defaultVisibility" = "hidden";
      "explorer.confirmDelete" = false;
      "explorer.confirmDragAndDrop" = false;
      "workbench.tree.indent" = 12;

      #----- Git Settings -----
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

      #----- Vim Configuration -----
      "vim.leader" = " ";
      "vim.easymotion" = true;
      "vim.surround" = true;
      "vim.useSystemClipboard" = true;
      "vim.incsearch" = true;
      "vim.hlsearch" = true;
      "vim.ignorecase" = true;
      "vim.normalModeKeyBindings" = [
        # Buffer management
        {
          before = [
            "<Leader>"
            "q"
          ];
          commands = [ ":q!" ];
        }
        {
          before = [
            "<Leader>"
            "p"
          ];
          commands = [ ":bprevious" ];
        }
        {
          before = [
            "<Leader>"
            "n"
          ];
          commands = [ ":bnext" ];
        }
        {
          before = [
            "<Leader>"
            "x"
          ];
          commands = [ ":bd" ];
        }
        {
          before = [
            "<Leader>"
            "f"
          ];
          commands = [ "editor.action.formatDocument" ];
        }

        # Tab management
        {
          before = [
            "<Leader>"
            "t"
            "n"
          ];
          commands = [ "workbench.action.nextEditor" ];
        }
        {
          before = [
            "<Leader>"
            "t"
            "p"
          ];
          commands = [ "workbench.action.previousEditor" ];
        }
        {
          before = [
            "<Leader>"
            "t"
            "c"
          ];
          commands = [ "workbench.action.newEditor" ];
        }

        # Window management
        {
          before = [
            "<Leader>"
            "v"
          ];
          commands = [ "workbench.action.splitEditorRight" ];
        }
        {
          before = [
            "<Leader>"
            "s"
          ];
          commands = [ "workbench.action.splitEditorDown" ];
        }

        # Window navigation
        {
          before = [
            "<Leader>"
            "h"
          ];
          commands = [ "workbench.action.navigateLeft" ];
        }
        {
          before = [
            "<Leader>"
            "j"
          ];
          commands = [ "workbench.action.navigateDown" ];
        }
        {
          before = [
            "<Leader>"
            "k"
          ];
          commands = [ "workbench.action.navigateUp" ];
        }
        {
          before = [
            "<Leader>"
            "l"
          ];
          commands = [ "workbench.action.navigateRight" ];
        }
        {
          before = [
            "<Leader>"
            "e"
          ];
          commands = [ "workbench.files.action.focusFilesExplorer" ];
        }
      ];

      "vim.handleKeys" = {
        "<C-a>" = false; # Preserve select all
        "<C-f>" = false; # Preserve find
        "<C-d>" = false;
        "<C-b>" = false; # Preserve scroll up
        "<C-c>" = false; # Preserve copy
      };

      # Status bar colors
      "vim.statusBarColors.normal" = [
        "#1d2021"
        "#a89984"
      ];
      "vim.statusBarColors.insert" = [
        "#1d2021"
        "#689d6a"
      ];
      "vim.statusBarColors.visual" = [
        "#1d2021"
        "#b16286"
      ];
      "vim.statusBarColors.visualline" = [
        "#1d2021"
        "#b16286"
      ];
      "vim.statusBarColors.visualblock" = [
        "#1d2021"
        "#d79921"
      ];
      "vim.statusBarColors.replace" = [
        "#1d2021"
        "#d65d0e"
      ];

      #----- Extensions -----
      "tabnine.experimentalAutoImports" = true;

    };
  };
}
