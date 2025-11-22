{ pkgs, ... }:
let
  jonathanharty-gruvbox-material-icon-theme = pkgs.vscode-utils.buildVscodeMarketplaceExtension {
    mktplcRef = {
      name = "gruvbox-material-icon-theme";
      publisher = "JonathanHarty";
      version = "1.1.5";
      hash = "sha256-86UWUuWKT6adx4hw4OJw3cSZxWZKLH4uLTO+Ssg75gY=";
    };
  };
in
{
  programs.vscode = {
    enable = true;
    profiles.default = {
      extensions =
        (with pkgs.vscode-extensions; [
          # Essentials & Utilities
          # ahgood.shift-shift
          # albert.tabout
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

          # Languages Support
          arrterian.nix-env-selector
          golang.go
          jnoortheen.nix-ide
          llvm-vs-code-extensions.vscode-clangd
          ms-python.debugpy
          ms-python.python
          # ms-python.vscode-python-envs
          rust-lang.rust-analyzer
          tamasfe.even-better-toml
          ziglang.vscode-zig

          # Dev Tools
          ms-azuretools.vscode-containers
          ms-azuretools.vscode-docker
          # mtxr.sqltools
          # mtxr.sqltools-driver-mysql
          vadimcn.vscode-lldb

          # Themes & Icons
          jdinhlife.gruvbox
          pkief.material-icon-theme
        ])
        ++ [
          # Custom icon theme
          jonathanharty-gruvbox-material-icon-theme
        ];
    };
  };
}
