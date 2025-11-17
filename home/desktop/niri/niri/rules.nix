_:
let
  windowRules = [
    {
      geometry-corner-radius =
        let
          radius = 12.0;
        in
        {
          bottom-left = radius;
          bottom-right = radius;
          top-left = radius;
          top-right = radius;
        };
      clip-to-geometry = true;
      draw-border-with-background = false;
    }
    {
      matches = [
        { is-floating = true; }
      ];
      shadow.enable = true;
    }
    {
      matches = [
        {
          is-window-cast-target = true;
        }
      ];
    }
    {
      matches = [
        { app-id = "org.telegram.desktop"; }
        { app-id = "app.drey.PaperPlane"; }
      ];
      block-out-from = "screencast";
    }
    {
      matches = [
        { app-id = "zen"; }
        { app-id = "firefox"; }
        { app-id = "chromium-browser"; }
        { app-id = "xdg-desktop-portal-gtk"; }
      ];
      scroll-factor = 0.5;
    }
    {
      matches = [
        { app-id = "zen"; }
        { app-id = "firefox"; }
        { app-id = "chromium-browser"; }
        { app-id = "edge"; }
      ];
      open-maximized = true;
    }
    {
      matches = [
        {
          app-id = "zen";
          title = "Picture-in-Picture";
        }
        {
          app-id = "firefox";
          title = "Picture-in-Picture";
        }
      ];
      open-floating = true;
      default-floating-position = {
        x = 32;
        y = 32;
        relative-to = "bottom-right";
      };
      default-column-width = {
        fixed = 480;
      };
      default-window-height = {
        fixed = 270;
      };
    }
    {
      matches = [
        { title = "Picture in picture"; }
        { title = "Discord Popout"; }
      ];
      open-floating = true;
      default-floating-position = {
        x = 32;
        y = 32;
        relative-to = "bottom-right";
      };
    }

    {
      matches = [
        { app-id = "pavucontrol"; }
        { app-id = "pavucontrol-qt"; }
        { app-id = "com.saivert.pwvucontrol"; }
        { app-id = "io.github.fsobolev.Cavalier"; }
        { app-id = "dialog"; }
        { app-id = "popup"; }
        { app-id = "task_dialog"; }
        { app-id = "gcr-prompter"; }
        { app-id = "file-roller"; }
        { app-id = "org.gnome.FileRoller"; }
        { app-id = "nm-connection-editor"; }
        { app-id = "blueman-manager"; }
        { app-id = "xdg-desktop-portal-gtk"; }
        { app-id = "org.kde.polkit-kde-authentication-agent-1"; }
        { app-id = "pinentry"; }
        { title = "Progress"; }
        { title = "File Operations"; }
        { title = "Copying"; }
        { title = "Moving"; }
        { title = "Properties"; }
        { title = "Downloads"; }
        { title = "file progress"; }
        { title = "Confirm"; }
        { title = "Authentication Required"; }
        { title = "Notice"; }
        { title = "Warning"; }
        { title = "Error"; }
        { app-id = "nm-connection-editor"; }
        { app-id = "flameshot"; }
        { app-id = "com.github.hluk.copyq"; }
        { app-id = "be.alexandervanhee.gradia"; }
        { app-id = "waypaper"; }
        { app-id = "clipse-gui"; }
        { title = "图片查看器"; }
        { title = "群聊的聊天记录"; }
        { title = "画中画"; }
        { title = "重命名"; }
        {
          app-id = "steam";
          title = "Friends List";
        }
        {
          app-id = "blueberry.py";
          title = "蓝牙";
        }
        {
          app-id = "org.pulseaudio.pavucontrol";
          title = "音量控制";
        }
        {
          app-id = "org.gnome.clocks";
          title = "时钟";
        }
        {
          app-id = "fcitx";
          title = "Fcitx5 输入窗口";
        }
        { app-id = "org.gnome.FileRoller"; }
        {
          app-id = "thunar";
          title = "文件操作进度";
        }
      ];
      open-floating = true;
    }

    {
      matches = [ { app-id = "^org\\.wezfurlong\\.wezterm$"; } ];
      default-column-width = { };
    }

    {
      matches = [
        { app-id = "fcitx"; }
        { app-id = "wechat"; }
      ];
      open-focused = false;
    }

    {
      clip-to-geometry = true;
      opacity = 0.99;
      draw-border-with-background = false;
    }
  ];
in
{
  programs.niri.settings = {
    window-rules = windowRules;
    layer-rules = [
      {
        matches = [ { namespace = "dms:blurwallpaper"; } ];
        place-within-backdrop = true;
      }
    ];
  };
}
