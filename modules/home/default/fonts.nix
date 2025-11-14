{ pkgs, ... }:
{
  fonts.fontconfig.enable = true;
  home.packages = with pkgs; [
    fantasque-sans-mono
    liberation_ttf
    maple-mono.NF-CN-unhinted
    maple-mono.NF-unhinted
    maple-mono.truetype
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-code
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    twemoji-color-font
  ];
}
