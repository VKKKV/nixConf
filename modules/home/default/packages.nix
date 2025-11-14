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
    cmake
    gnumake

    # Core utils replacements
    duf
    fd
    ripgrep

    # TUI applications
    calc
    cloc
    fastfetch

    # System utilities
    ffmpeg
    killall
    libnotify
    openssl
    poweralertd
    udiskie
    unzip
    p7zip
    wget
    xdg-utils
  ];
}
