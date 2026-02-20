{...}: {
  programs.waybar.settings.mainBar = {
    # Basic layout settings
    layer = "top";
    position = "bottom";
    mod = "dock";
    height = 28;
    exclusive = false;
    fixed-center = true;
    passthrough = false;
    gtk-layer-shell = true;
    reload_style_on_change = true;

    # Margin settings
    margin-top = 0;
    margin-bottom = 0;
    margin-left = 0;

    # Module layout
    modules-center = [
      "custom/left_div#4"
      "clock"
      "pulseaudio"
      "tray"
      "custom/right_div#4"
    ];

    # Custom separator modules
    "custom/left_div#4" = {
      format = "";
      tooltip = false;
    };

    "custom/right_div#4" = {
      format = "";
      tooltip = false;
    };

    # Module detailed configuration
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
      tooltip-format = "Current performance mode: {profile}\n---\nLeft click: Switch performance mode";
      tooltip = true;
      format-icons = {
        performance = "󱐋";
        balanced = "";
        power-saver = "";
      };
    };
  };
}
