{
  pkgs,
  inputs,
  ...
}: {
  /**
  * system/common/apps/default.nix
  * Shared system applications and Flatpak integration.
  */

  imports = [
    inputs.nix-flatpak.nixosModules.nix-flatpak
  ];

  # --- Flatpak ---
  xdg.portal.enable = true;
  services.flatpak = {
    enable = true;
    update.auto = {
      enable = true;
      onCalendar = "weekly";
    };
    overrides.global.Context.sockets = ["wayland" "!x11" "!fallback-x11"];
  };

  services.kmscon = {
    enable = true;
    fonts = with pkgs; [
      {
        name = "Maple Mono NF CN";
        package = maple-mono.NF-CN-unhinted;
      }
      {
        name = "Source Han Mono SC";
        package = source-han-mono;
      }
      {
        name = "JetBrainsMono Nerd Font";
        package = nerd-fonts.jetbrains-mono;
      }
    ];
    extraOptions = "--term xterm";
    extraConfig = "font-size=19";
    hwRender = true;
  };
}
