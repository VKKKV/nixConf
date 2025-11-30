{
  config,
  username,
  inputs,
  pkgs,
  ...
}: {
  imports = [inputs.zen-browser.homeModules.beta];

  stylix.targets.zen-browser = {
    enable = true;
    profileNames = ["${username}"];
  };

  programs.zen-browser = {
    enable = true;
    languagePacks = [
      "zh-CN"
      "zh-TW"
      "en-US"
      "ja"
    ];
    policies = let
      mkExtensionSettings = builtins.mapAttrs (
        _: pluginId: {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/${pluginId}/latest.xpi";
          installation_mode = "force_installed";
        }
      );
    in {
      AutofillAddressEnabled = true;
      AutofillCreditCardEnabled = false;
      DisableAppUpdate = true;
      DisableFeedbackCommands = true;
      DisableFirefoxStudies = true;
      DisablePocket = true;
      DisableTelemetry = true;
      DontCheckDefaultBrowser = true;
      NoDefaultBookmarks = true;
      OfferToSaveLogins = false;

      Homepage.StartPage = "previous-session";

      UserMessaging = {
        SkipOnboarding = true;
      };

      FirefoxSuggest = {
        SponsoredSuggestions = false; # 禁用广告赞助建议
        ImproveSuggest = false; # 禁止收集数据以改进建议服务
      };

      FirefoxHome = {
        Search = true; # 显示搜索框
        TopSites = false; # 隐藏常用网站
        SponsoredTopSites = false; # 隐藏赞助的常用网站
        Highlights = false; # 隐藏收藏集锦
        Pocket = false; # 隐藏 Pocket 推荐
        SponsoredPocket = false; # 隐藏 Pocket 赞助内容
        Snippets = false; # 隐藏 Mozilla 动态消息
      };

      Handlers.schemes.vscode = {
        action = "useSystemDefault"; # 自动使用系统默认应用（VS Code）
        ask = false; # 不再询问
      };

      Handlers.schemes.element = {
        action = "useSystemDefault"; # 自动使用系统默认应用（Element 矩阵客户端）
        ask = false;
      };

      EnableTrackingProtection = {
        Value = true;
        Locked = true;
        Cryptomining = true;
        Fingerprinting = true;
      };

      ExtensionSettings = mkExtensionSettings {
        "{c3c10168-4186-445c-9c5b-63f12b8e2c87}" = "cookie-editor";
        "{f4961478-ac79-4a18-87e9-d2fb8c0442c4}" = "global-speed";
        "hackbar@chewbaka" = "hackbar-free";
        "jid1-5Fs7iTLscUaZBgwr@jetpack" = "happy-bonobo-disable-webrtc";
        "jid1-NIfFY2CA8fy1tg@jetpack" = "adblock-for-firefox";
      };
    };

    profiles."${username}}" = {
      id = 0;
      isDefault = true;
      name = "${username}";

      search = {
        force = true;
        default = "google";
        order = [
          "google"
          "bing"
          "ddg"
          "Baidu"
        ];
      };

      extensions.packages = with inputs.firefox-addons.packages.${pkgs.stdenv.hostPlatform.system}; [
        ublock-origin
        unofficial-saladict-popup-dictionary
        # immersive-translate
        # tampermonkey
        bilisponsorblock
        bitwarden
        canvasblocker
        darkreader
        hacktools
        tridactyl
        ublock-origin
        ruffle_rs
      ];
    };
  };

  xdg.mimeApps = let
    value = let
      zen-browser = inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.beta;
    in
      zen-browser.meta.desktopFileName;

    associations = builtins.listToAttrs (
      map (name: {inherit name value;}) [
        "application/x-extension-shtml"
        "application/x-extension-xhtml"
        "application/x-extension-html"
        "application/x-extension-xht"
        "application/x-extension-htm"
        "x-scheme-handler/unknown"
        "x-scheme-handler/mailto"
        "x-scheme-handler/chrome"
        "x-scheme-handler/about"
        "x-scheme-handler/https"
        "x-scheme-handler/http"
        "application/xhtml+xml"
        "application/json"
        "text/html"
      ]
    );
  in {
    associations.added = associations;
    defaultApplications = associations;
  };
}
