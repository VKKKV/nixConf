/**
 * system/common/game.nix
 * Gaming-specific optimizations and launchers.
 * Includes Steam, gamescope, and specialized game launchers with performance tweaks.
 */
{
  pkgs,
  inputs,
  ...
}:
with inputs; {
  imports = [
    nix-gaming.nixosModules.pipewireLowLatency
    nix-gaming.nixosModules.platformOptimizations
    aagl.nixosModules.default
  ];

  # Disable branch check for Anime Game Launcher (AAGL)
  aagl.enableNixpkgsReleaseBranchCheck = false;

  programs = {
    # Steam configuration with various compatibility and performance features
    steam = {
      enable = true;
      gamescopeSession.enable = true;
      protontricks.enable = true;
      extest.enable = true;
      extraCompatPackages = [pkgs.proton-ge-bin];
      fontPackages = [
        pkgs.wqy_zenhei # Fallback font for Steam's Chinese UI
      ];

      # Enable platform-specific optimizations from nix-gaming
      platformOptimizations.enable = true;
    };

    # Gamemode: Optimizes system performance on-demand for games
    gamemode.enable = true;

    # Gamescope: Micro-compositor for gaming
    gamescope = {
      enable = true;
      capSysNice = true;
      args = [
        "--rt"
        "--expose-wayland"
      ];
    };

    # Specialized game launchers for various titles
    # https://github.com/ezKEa/aagl-gtk-on-nix
    anime-game-launcher.enable = true;
    honkers-railway-launcher.enable = true;
    sleepy-launcher.enable = true;
  };

  # Low-latency Pipewire configuration for improved audio response in games
  services.pipewire.lowLatency = {
    enable = true;
    quantum = 32;
    rate = 48000;
  };

  # Additional gaming packages
  environment.systemPackages = [
    pkgs.bottles
    nix-gaming.packages.${pkgs.stdenv.hostPlatform.system}.osu-lazer-bin
  ];
}
