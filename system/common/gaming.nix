{
  pkgs,
  inputs,
  ...
}: {
  imports = [inputs.nix-gaming.nixosModules.pipewireLowLatency inputs.nix-gaming.nixosModules.platformOptimizations inputs.aagl.nixosModules.default];
  # --- Gaming ---
  aagl.enableNixpkgsReleaseBranchCheck = false;
  programs = {
    steam = {
      enable = true;
      gamescopeSession.enable = true;
      protontricks.enable = true;
      extest.enable = true;
      extraCompatPackages = [pkgs.proton-ge-bin];
      fontPackages = [pkgs.wqy_zenhei];
      platformOptimizations.enable = true;
    };
    gamemode.enable = true;
    gamescope = {
      enable = true;
      capSysNice = true;
      args = ["--rt" "--expose-wayland"];
    };
    anime-game-launcher.enable = true;
    honkers-railway-launcher.enable = true;
    sleepy-launcher.enable = true;
  };
  services.pipewire.lowLatency = {
    enable = true;
    quantum = 32;
    rate = 48000;
  };
}
