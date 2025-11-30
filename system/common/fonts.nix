{pkgs, ...}: {
  fonts = {
    packages = with pkgs; [
      material-design-icons
      font-awesome

      nerd-fonts.symbols-only # symbols icon only
      nerd-fonts.fira-code
      nerd-fonts.jetbrains-mono
      nerd-fonts.iosevka

      noto-fonts # 大部分文字的常见样式，不包含汉字
      noto-fonts-color-emoji # 彩色的表情符号字体
      noto-fonts-cjk-sans # 思源黑体
      noto-fonts-cjk-serif # 思源宋体

      source-sans # 无衬线字体，不含汉字。字族名叫 Source Sans 3，以及带字重的变体（VF）
      source-serif # 衬线字体，不含汉字。字族名叫 Source Serif 4，以及带字重的变体
      source-han-sans # 思源黑体
      source-han-serif # 思源宋体
      source-han-mono # 思源等宽

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
        serif = [
          "Source Han Serif SC" # 思源宋体
          "Source Serif 4"
          "Source Han Serif TC"
        ];
        sansSerif = [
          "LXGW WenKai Screen" # 霞鹜文楷 屏幕阅读版
          "Source Sans 3"
          "Source Han Sans SC" # 思源黑体
          "Source Han Sans TC"
        ];
        monospace = [
          "Maple Mono NF CN" # 中英文宽度完美 2:1 的字体
          "JetBrainsMono Nerd Font"
          "Source Han Mono SC" # 思源等宽
          "Source Han Mono TC"
        ];
        emoji = ["Noto Color Emoji"];
      };
    };

    # causes more issues than it solves
    enableDefaultPackages = false;

    fontDir = {
      enable = true;
      decompressFonts = true;
    };

    # Improve font rendering performance
    fontconfig.cache32Bit = true;
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
