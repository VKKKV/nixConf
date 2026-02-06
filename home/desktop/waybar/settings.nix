{...}: {
  programs.waybar.settings.mainBar = {
    # 基础布局设置
    layer = "top";
    position = "bottom";
    mod = "dock";
    height = 28; # 根据你提供的列表，这里改为了 28
    exclusive = false;
    fixed-center = true;
    passthrough = false;
    gtk-layer-shell = true;
    reload_style_on_change = true;

    # 边距设置
    margin-top = 0;
    margin-bottom = 0;
    margin-left = 0;

    # 模块布局
    modules-center = [
      "custom/left_div#4"
      "clock"
      "pulseaudio"
      "tray"
      "custom/right_div#4"
    ];

    # 自定义分隔符模块
    "custom/left_div#4" = {
      format = "";
      tooltip = false;
    };

    "custom/right_div#4" = {
      format = "";
      tooltip = false;
    };

    # 模块详细配置
    tray = {
      spacing = 10;
      tooltip = false;
    };

    clock = {
      format = "{:%a, %d %I:%M}";
      tooltip = true;
    };

    pulseaudio = {
      scroll-step = 5;
      max-volume = 150;
      format = "vol{volume}%";
      format-muted = "MUTED";
      format-bluetooth = "vol{volume}%";
      nospacing = 1;
      on-click = "pwvucontrol";
      tooltip = false;
    };
    power-profiles-daemon = {
      format = "{icon}";
      tooltip-format = "当前性能模式：{profile}\n---\n左键：切换性能模式";
      tooltip = true;
      format-icons = {
        performance = "󱐋";
        balanced = "";
        power-saver = "";
      };
    };
  };
}
