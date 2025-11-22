{ pkgs, ... }:
# Wayland config
{
  imports = [
    ./niri
    ./waybarShorin
    ./quickshell.nix
  ];

  home.packages = with pkgs; [
    grimblast
    # utils
    wl-clip-persist
    localsend
    pwvucontrol
    cliphist

    blueberry # 蓝牙图形界面
    gnome-calendar
    gnome-clocks
    pavucontrol # PulseAudio 控制面板
    fuzzel # 应用程序启动器
    waypaper # 背景图片选择器
    wlogout # 电源菜单界面
    # 系统工具
    power-profiles-daemon
    upower # 电池状态
    playerctl # MPRIS 媒体控制
    libnotify # 通知工具
    swaynotificationcenter # 通知中心
    ddcutil # 显示器亮度控制
    wl-clipboard # Wayland 剪贴板 (wl-copy)

    # Wayland 工具
    grim # 截图捕获
    slurp # 区域选择
    hyprpicker # 颜色选择器
    cava # 音频可视化器
    # 终端工具
    networkmanager # 用于 nmtui
    # 音频
    wireplumber # wpctl 音频控制
    # 蓝牙
    bluez # 蓝牙协议栈
    bluez-tools
    # 守护进程
    blueman # 蓝牙管理
    udisks2 # 磁盘管理用于托盘图标
  ];

  home.sessionVariables = {
    CLUTTER_BACKEND = "wayland";
    GDK_BACKEND = "wayland,x11";
    MOZ_ENABLE_WAYLAND = "1";
    NIXOS_OZONE_WL = "1";
    QT_QPA_PLATFORM = "wayland;xcb";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    SDL_VIDEODRIVER = "wayland";
    WLR_RENDERER = "vulkan";
    XDG_CURRENT_DESKTOP = "niri";
    XDG_SESSION_TYPE = "wayland";
    XMODIFIERS = "@im=fcitx";
  };

  services = {
    swww = {
      enable = true;
    };
    mako = {
      enable = true;
      settings = {
        # Default settings for normal notifications
        border-radius = 8;
        border-size = 2;
        default-timeout = 8000;
        height = 100;
        icons = true;
        ignore-timeout = false;
        layer = "top";
        margin = 10;
        markup = true;
        width = 300;

        # Settings for actionable notifications
        "actionable=true" = {
          anchor = "top-left";
        };
        actions = true;
        anchor = "top-right";

        # Settings for urgent notifications
        "urgency=high" = {
          default-timeout = 0; # Don't timeout urgent notifications
        };
      };
    };
  };
}
