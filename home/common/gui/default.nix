{
  username,
  inputs,
  pkgs,
  lib,
  ...
}: {
  /**
   * home/common/gui/default.nix
   * Consolidated GUI applications and desktop utilities.
   */

  imports = [
    inputs.zen-browser.homeModules.beta
    ./fcitx5
    ./vscodium
  ];

  # --- Zen Browser ---
  stylix.targets.zen-browser = {
    enable = true;
    profileNames = [username];
  };

  programs.zen-browser = {
    enable = true;
    languagePacks = ["zh-CN" "zh-TW" "en-US" "ja"];
    policies = let
      mkExtensionSettings = builtins.mapAttrs (
        _: pluginId: {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/${pluginId}/latest.xpi";
          installation_mode = "force_installed";
        }
      );
    in {
      DisableAppUpdate = true;
      DisableTelemetry = true;
      DisablePocket = true;
      DisableFirefoxStudies = true;
      DontCheckDefaultBrowser = true;
      NoDefaultBookmarks = true;
      OfferToSaveLogins = false;
      AutofillAddressEnabled = true;
      AutofillCreditCardEnabled = false;
      Homepage.StartPage = "previous-session";
      UserMessaging.SkipOnboarding = true;
      FirefoxSuggest = {
        SponsoredSuggestions = false;
        ImproveSuggest = false;
      };
      FirefoxHome = {
        Search = true;
        TopSites = false;
        SponsoredTopSites = false;
        Highlights = false;
        Pocket = false;
        SponsoredPocket = false;
        Snippets = false;
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
    profiles."${username}" = {
      id = 0;
      isDefault = true;
      name = "${username}";
      search = {
        force = true;
        default = "google";
        order = ["google" "bing" "ddg" "Baidu"];
      };
      extensions.packages = with inputs.firefox-addons.packages.${pkgs.stdenv.hostPlatform.system}; [
        ublock-origin
        unofficial-saladict-popup-dictionary
        bilisponsorblock
        bitwarden
        canvasblocker
        darkreader
        hacktools
        tridactyl
        ruffle_rs
      ];
    };
  };

  # --- MPV Configuration ---
  programs.mpv = {
    enable = true;
    scripts = with pkgs.mpvScripts; [
      mpris
      uosc
      thumbfast
      autoload
      quality-menu
    ];
  };
  xdg.configFile."mpv" = {
    source = inputs.mpv-config;
    recursive = true;
  };

  # --- Discord ---
  home.packages = with pkgs; [
    webcord-vencord
  ];

  # --- Yazi (Terminal File Manager) ---
  programs.yazi = {
    enable = true;
    enableBashIntegration = true;
    settings = {
      mgr = {
        ratio = [1 3 4];
        sort_by = "alphabetical";
        sort_sensitive = false;
        sort_reverse = false;
        sort_dir_first = true;
        sort_translit = false;
        mouse_events = [];
        linemode = "size";
        show_hidden = false;
        show_symlink = true;
        scrolloff = 5;
        title_format = "Yazi: {cwd}";
      };
      preview = {
        tab_size = 2;
        max_width = 600;
        max_height = 900;
        cache_dir = "";
        image_filter = "triangle";
        image_quality = 75;
        sixel_fraction = 15;
        ueberzug_scale = 1;
        ueberzug_offset = [0 0 0 0];
      };
      opener = {
        play = [{run = "mpv \"$@\""; orphan = true; for = "unix";}];
        edit = [{run = "vim \"$@\""; block = true; for = "unix";}];
      };
      open.rules = [
        {mime = "text/*"; use = "edit";}
        {mime = "*"; use = "edit";}
      ];
    };
    keymap.mgr.prepend_keymap = [
      {on = "z"; run = "plugin zoxide"; desc = "Jump to a directory via zoxide";}
      {on = "Z"; run = "plugin fzf"; desc = "Jump to a file/directory via fzf";}
    ];
  };

  # --- Zathura (PDF Viewer) ---
  programs.zathura = {
    enable = true;
    options = {
      zoom-min = "10";
      scroll-page-aware = "true";
      scroll-full-overlap = "0.01";
      scroll-step = "100";
      statusbar-basename = "true";
      statusbar-home-tilde = "true";
      statusbar-page-percent = "true";
      adjust-open = "best-fit";
      pages-per-row = "1";
      page-h-padding = "0";
      page-v-padding = "0";
      page-right-to-left = "true";
      render-loading = "true";
    };
  };

  # --- MIME Associations ---
  xdg.mimeApps = let
    zenValue = (inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.beta).meta.desktopFileName;
    browserAssociations = builtins.listToAttrs (
      map (name: {name = name; value = zenValue;}) [
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
    associations.added = browserAssociations;
    defaultApplications = browserAssociations;
  };
}
