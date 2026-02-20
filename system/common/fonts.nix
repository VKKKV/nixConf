/**
 * system/common/fonts.nix
 * Font installation and rendering configuration.
 * Includes a wide range of international fonts and high-quality rendering settings.
 */
{pkgs, ...}: {
  fonts = {
    # Installed font packages
    packages = with pkgs; [
      material-design-icons
      font-awesome

      nerd-fonts.symbols-only
      nerd-fonts.fira-code
      nerd-fonts.jetbrains-mono
      nerd-fonts.iosevka

      # International & CJK Fonts
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

    # Fontconfig configuration for high-quality rendering
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

      # Default font assignments for generic aliases
      defaultFonts = {
        serif = [
          "Source Han Serif SC"
          "Source Serif 4"
          "Source Han Serif TC"
        ];
        sansSerif = [
          "LXGW WenKai Screen"
          "Source Sans 3"
          "Source Han Sans SC"
          "Source Han Sans TC"
        ];
        monospace = [
          "Maple Mono NF CN"
          "JetBrainsMono Nerd Font"
          "Source Han Mono SC"
          "Source Han Mono TC"
        ];
        emoji = ["Noto Color Emoji"];
      };
    };

    # Custom font directory management
    enableDefaultPackages = false;
    fontDir = {
      enable = true;
      decompressFonts = true;
    };

    # Rendering performance optimization
    fontconfig.cache32Bit = true;
  };

  # KMS Console configuration with high-quality fonts
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
