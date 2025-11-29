{ pkgs, ... }:
{
  stylix.targets.fcitx5.enable = false;

  i18n.inputMethod = {
    type = "fcitx5";
    enable = true;
    fcitx5 = {
      waylandFrontend = true;

      addons = with pkgs; [
        fcitx5-gtk
        qt6Packages.fcitx5-configtool

        fcitx5-mozc
        (fcitx5-rime.override {
          rimeDataPkgs = [
            # pkgs.local.rime-shuangpin-fuzhuma
            pkgs.rime-data
          ];
        })
      ];

      settings = {
        addons = {
          classicui = {
            globalSection = {
              Theme = "macOS-light";
              DarkTheme = "macOS-dark";
              Font = "Maple Mono NF CN 16";
              MenuFont = "Maple Mono NF CN 16";
              TrayFont = "Maple Mono NF CN 16";
            };
          };
        };

        inputMethod = {
          GroupOrder."0" = "Default";
          "Groups/0" = {
            Name = "Default";
            "Default Layout" = "us";
            DefaultIM = "rime";
          };
          "Groups/0/Items/0".Name = "keyboard-us";
          "Groups/0/Items/1".Name = "rime";
          "Groups/0/Items/2".Name = "mozc";
        };

        globalOptions = {
          "Hotkey/EnumerateGroupForwardKeys" = {
            "0" = "Super+space";
          };
          "Hotkey/TriggerKeys" = {
            "0" = "Super+Shift_L";
          };
        };
      };
    };
  };

  xdg.dataFile."fcitx5/rime" = {
    source = ./config;
    recursive = true;
  };

  xdg.dataFile."fcitx5/themes" = {
    source = ./themes;
    recursive = true;
  };

}
