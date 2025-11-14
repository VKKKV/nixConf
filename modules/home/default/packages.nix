{ inputs, pkgs, ... }:
{
  imports = [
    inputs.nix-index-database.homeModules.nix-index
  ];

  programs = {
    nix-index = {
      enable = true;
      symlinkToCacheHome = true;
      enableZshIntegration = false;
    };

    nix-index-database.comma.enable = true;
  };

  home.packages = with pkgs; [
    # Development tools
    nodejs_24
    nixfmt
    nixd

    # C/C++ tools
    gcc
    gdb
    gef
    cmake
    gnumake

    # Core utils replacements
    zsh
    duf
    fd
    ripgrep
    man-pages

    # TUI applications
    calc
    cloc
    fastfetch

    # System utilities
    ffmpeg
    jq
    killall
    libnotify
    mimeo
    openssl
    pamixer
    playerctl
    poweralertd
    udiskie
    unzip
    p7zip
    wget
    xdg-utils
  ];
}
