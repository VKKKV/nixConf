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
    # Multimedia
    audacity
    gimp
    obs-studio
    pavucontrol
    pwvucontrol
    soundwireserver

    # Office
    onlyoffice

    # System utilities
    localsend
    nix-search-tv

    # Development tools
    nodejs_24
    nixd
    shfmt
    treefmt
    nixfmt-rfc-style

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

    # Monitoring/fetch tools
    btop
    fastfetch

    # Fun/terminal toys
    cowsay
    figlet
    lolcat
    tty-clock

    # Media players
    mpv

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
    wl-clipboard
    xdg-utils
  ];
}
