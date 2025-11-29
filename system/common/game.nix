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

  programs = {
    steam = {
      enable = true;
      gamescopeSession.enable = true;
      protontricks.enable = true;
      extest.enable = true;
      # remotePlay.openFirewall = true;
      # dedicatedServer.openFirewall = false;
      extraCompatPackages = [pkgs.proton-ge-bin];
      fontPackages = [
        pkgs.wqy_zenhei # Need by steam for Chinese
      ];

      # nix-gaming option
      platformOptimizations.enable = true;
    };

    gamemode.enable = true;

    gamescope = {
      enable = true;
      capSysNice = true;
      args = [
        "--rt"
        "--expose-wayland"
      ];
    };

    # https://github.com/ezKEa/aagl-gtk-on-nix
    anime-game-launcher.enable = true;
    honkers-railway-launcher.enable = true;
    sleepy-launcher.enable = true;
  };

  # see https://github.com/fufexan/nix-gaming/#pipewire-low-latency
  services.pipewire.lowLatency = {
    enable = true;
    quantum = 32;
    rate = 48000;
  };

  environment.systemPackages = [
    pkgs.bottles
    nix-gaming.packages.${pkgs.stdenv.hostPlatform.system}.osu-lazer-bin
  ];
}
