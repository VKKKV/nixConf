/**
 * system/common/stylix/default.nix
 * Global system and user theming using Stylix.
 * Configures colors, fonts, and cursors consistently across all supported applications.
 */
{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.stylix.nixosModules.stylix
  ];

  programs.dconf.enable = true;

  environment.systemPackages = with pkgs; [
    dconf # 存储应用程序的设置
    glib # for gsettings to work

    # Qt
    libsForQt5.qt5ct
    libsForQt5.qtstyleplugin-kvantum # kvantum
    kdePackages.qt6ct
    kdePackages.qtstyleplugin-kvantum # kvantum
    kdePackages.qtwayland
    gsettings-qt # 访问和修改应用程序设置的工具

    # GTK
    nwg-look # GTK主题管理工具
    gsettings-desktop-schemas
    xsettingsd # gtk 守护进程
    gtk-engine-murrine # GTK+ 2.x 的一个 主题引擎

    # theme
    adwaita-icon-theme
    material-symbols
    adw-gtk3
    morewaita-icon-theme
  ];

  stylix = {
    enable = true;
    autoEnable = true;
    enableReleaseChecks = false;

    targets = {
      limine.enable = false;
    };

    polarity = "dark";

    opacity = {
      popups = 1.0;
      terminal = 1.0;
    };

    base16Scheme = ./color/gruvbox-dark.yml;

    cursor = {
      name = "Bibata-Modern-Ice";
      package = pkgs.bibata-cursors;
      size = 24;
    };

    fonts = with pkgs; {
      serif = {
        name = "Source Han Serif SC"; # 思源宋体
        package = source-han-serif;
      };
      sansSerif = {
        name = "Source Han Sans SC"; # 思源黑体
        package = source-han-sans;
      };
      monospace = {
        name = "MapleMono NF CN";
        package = maple-mono.NF-CN-unhinted;
      };
      emoji = {
        name = "Noto Font Emoji";
        package = noto-fonts-color-emoji;
      };

      sizes = {
        applications = 14;
        desktop = 14;
        popups = 14;
        terminal = 14;
      };
    };
  };
}
