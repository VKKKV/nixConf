{
  pkgs,
  inputs,
  ...
}: {
  /**
   * system/common/apps/default.nix
   * Consolidated system-wide applications and fonts.
   */

  imports = [
    inputs.nix-flatpak.nixosModules.nix-flatpak
    ./game.nix
    ./minecraft.nix
    ./remix.nix
    ./virtualization.nix
  ];

  # --- Flatpak Configuration ---
  xdg.portal.enable = true;
  services.flatpak = {
    enable = true;
    update.auto = {
      enable = true;
      onCalendar = "weekly";
    };
    overrides.global.Context.sockets = ["wayland" "!x11" "!fallback-x11"];
  };

  # --- Fonts Configuration ---
  fonts = {
    packages = with pkgs; [
      material-design-icons
      font-awesome
      nerd-fonts.symbols-only
      nerd-fonts.fira-code
      nerd-fonts.jetbrains-mono
      nerd-fonts.iosevka
      noto-fonts
      noto-fonts-color-emoji
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      source-sans
      source-serif
      source-han-sans
      source-han-serif
      source-han-mono
      lxgw-wenkai-screen
      maple-mono.NF-CN-unhinted
    ];

    fontconfig = {
      enable = true;
      antialias = true;
      hinting = {
        enable = true;
        autohint = false;
        style = "full";
      };
      subpixel = {
        lcdfilter = "default";
        rgba = "rgb";
      };
      defaultFonts = {
        serif = ["Source Han Serif SC" "Source Serif 4" "Source Han Serif TC"];
        sansSerif = ["LXGW WenKai Screen" "Source Sans 3" "Source Han Sans SC" "Source Han Sans TC"];
        monospace = ["Maple Mono NF CN" "JetBrainsMono Nerd Font" "Source Han Mono SC" "Source Han Mono TC"];
        emoji = ["Noto Color Emoji"];
      };
      cache32Bit = true;
    };

    enableDefaultPackages = false;
    fontDir = {
      enable = true;
      decompressFonts = true;
    };
  };

  services.kmscon = {
    enable = true;
    fonts = with pkgs; [
      {name = "Maple Mono NF CN"; package = maple-mono.NF-CN-unhinted;}
      {name = "Source Han Mono SC"; package = source-han-mono;}
      {name = "JetBrainsMono Nerd Font"; package = nerd-fonts.jetbrains-mono;}
    ];
    extraOptions = "--term xterm";
    extraConfig = "font-size=19";
    hwRender = true;
  };

  # --- Thunar Configuration ---
  programs.thunar = {
    enable = true;
    plugins = with pkgs.xfce; [
      thunar-archive-plugin
      thunar-volman
    ];
  };
  programs.xfconf.enable = true;
  services.gvfs.enable = true;
  services.tumbler.enable = true;
}
