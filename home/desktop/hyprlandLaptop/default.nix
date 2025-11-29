{...}: {
  systemd.user.targets.hyprland-session.Unit.Wants = [
    "xdg-desktop-autostart.target"
  ];

  # config = lib.mkMerge [
  #   {
  #     services = {
  #       xserver.enable = false; # disable xorg server
  #       # https://wiki.archlinux.org/title/Greetd
  #       greetd = {
  #         enable = true;
  #         settings = {
  #           default_session = {
  #           };
  #         };
  #       };
  #     };
  #
  #     # fix https://github.com/ryan4yin/nix-config/issues/10
  #     security.pam.services.swaylock = { };
  #   }
  # ];

  wayland.windowManager.hyprland = {
    enable = true;
    package = null;
    portalPackage = null;

    xwayland = {
      enable = true;
    };
    # enableNvidiaPatches = false;
    systemd.enable = true;
  };

  xdg.configFile."hypr" = {
    source = ./config;
    recursive = true;
    executable = true;
  };
}
