{pkgs, ...}: {
  imports = [
    ./niri
    ./rofi
    ./waybarGruvbox
    ./waypaper.nix

    # ./hyprlandLaptop
    # ./swayidle.nix
    # ./swaylock.nix
    # ./waybarShorin
  ];

  home.packages = with pkgs; [
    blueberry # 蓝牙图形界面
    blueman # 蓝牙管理
    bluez # 蓝牙协议栈
    bluez-tools
    cava # 音频可视化器
    cliphist
    ddcutil # 显示器亮度控制
    direnv
    fuzzel # 应用程序启动器
    glib
    gnome-calendar
    gnome-clocks
    grim # 截图捕获
    grimblast
    hyprpicker # 颜色选择器
    libnotify # 通知工具
    localsend
    networkmanager # 用于 nmtui
    pavucontrol # PulseAudio 控制面板
    playerctl # MPRIS 媒体控制
    power-profiles-daemon
    pwvucontrol
    slurp # 区域选择
    swaynotificationcenter # 通知中心
    swww
    udisks2 # 磁盘管理用于托盘图标
    upower # 电池状态
    wayland
    waypaper # 背景图片选择器
    wireplumber # wpctl 音频控制
    wl-clip-persist
    wl-clipboard # Wayland 剪贴板 (wl-copy)
    wlogout # 电源菜单界面
  ];
}
