{ pkgs, ... }:
{
  fonts = {
    packages = with pkgs; [
      # icon fonts
      material-symbols

      # normal fonts
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-color-emoji
      adwaita-fonts
      fantasque-sans-mono
      liberation_ttf
      twemoji-color-font

      # nerdfonts
      nerd-fonts.symbols-only
      nerd-fonts.geist-mono
      maple-mono.NF-CN-unhinted
      maple-mono.NF-unhinted
      maple-mono.truetype
      nerd-fonts.jetbrains-mono
      nerd-fonts.fira-code
      noto-fonts-cjk-sans
      noto-fonts-color-emoji
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
      defaultFonts = let
        addAll = builtins.mapAttrs (_: v: ["Symbols Nerd Font"] ++ v ++ ["Noto Color Emoji"]);
      in
        addAll {
          serif = ["Noto Serif"];
          sansSerif = ["Adwaita Sans"];
          monospace = ["MapleMono NF CN"];
          emoji = ["Noto Color Emoji"];
        };
      };

    # causes more issues than it solves
    enableDefaultPackages = false;

    fontDir = {
      enable = true;
      decompressFonts = true;
    };
  };
}
