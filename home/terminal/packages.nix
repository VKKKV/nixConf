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
      package = pkgs.nix-index;
    };

    nix-index-database.comma.enable = true;
  };

  home.packages = with pkgs; [
    # Development tools - keep only what you actively use
    nodejs_24
    nixfmt
    
    # Language servers (install only what you need)
    nil

    # C/C++ tools - only if you're actively doing C/C++ development
    gcc
    # cmake
    # gnumake

    # Core utils replacements
    duf       # Disk usage - more efficient than du
    fd        # Find files - faster than find
    ripgrep   # Search in files - faster than grep

    # TUI applications
    calc      # Calculator
    cloc      # Count lines of code
    fastfetch # System information - lighter than neofetch

    # System utilities
    ffmpeg    # Only if you work with media files
    killall   # Process management
    libnotify # Desktop notifications
    openssl   # Cryptography
    poweralertd # Power management notifications
    udiskie   # USB device management
    unzip     # Archive extraction
    p7zip     # Archive extraction
    wget      # File downloading
    xdg-utils # Desktop integration
    
    # Performance optimization: Remove rarely used packages
    # Consider installing these on-demand when needed:
    # imagemagick  # Image manipulation
    # jq          # JSON processing
    # yq          # YAML processing
  ];
}