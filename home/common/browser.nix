/**
 * home/common/browser.nix
 * Zen Browser configuration.
 * Includes extensive privacy policies, curated extensions, and default web associations.
 */
{
  username,
  inputs,
  pkgs,
  ...
}: {
  imports = [inputs.zen-browser.homeModules.beta];

  stylix.enableReleaseChecks = false;

  stylix.targets.zen-browser = {
    enable = true;
    profileNames = [username];
  };

  programs.zen-browser = {
    enable = true;

    languagePacks = [
      "zh-CN"
      "zh-TW"
      "en-US"
      "ja"
    ];

    # Browser Policies: Privacy, Telemetry, and Functionality
    policies = let
      mkExtensionSettings = builtins.mapAttrs (
        _: pluginId: {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/${pluginId}/latest.xpi";
          installation_mode = "force_installed";
        }
      );
    in {
      # Privacy & Telemetry
      DisableAppUpdate = true;
      DisableTelemetry = true;
      DisablePocket = true;
      DisableFirefoxStudies = true;
      DontCheckDefaultBrowser = true;
      NoDefaultBookmarks = true;
      OfferToSaveLogins = false;

      # Functionality Settings
      AutofillAddressEnabled = true;
      AutofillCreditCardEnabled = false;
      Homepage.StartPage = "previous-session";
      UserMessaging.SkipOnboarding = true;

      # Search Suggestions
      FirefoxSuggest = {
        SponsoredSuggestions = false;
        ImproveSuggest = false;
      };

      # New Tab Page
      FirefoxHome = {
        Search = true;
        TopSites = false;
        SponsoredTopSites = false;
        Highlights = false;
        Pocket = false;
        SponsoredPocket = false;
        Snippets = false;
      };

      # Enhanced Tracking Protection
      EnableTrackingProtection = {
        Value = true;
        Locked = true;
        Cryptomining = true;
        Fingerprinting = true;
      };

      # Pre-installed extensions via policy
      ExtensionSettings = mkExtensionSettings {
        "{c3c10168-4186-445c-9c5b-63f12b8e2c87}" = "cookie-editor";
        "{f4961478-ac79-4a18-87e9-d2fb8c0442c4}" = "global-speed";
        "hackbar@chewbaka" = "hackbar-free";
        "jid1-5Fs7iTLscUaZBgwr@jetpack" = "happy-bonobo-disable-webrtc";
        "jid1-NIfFY2CA8fy1tg@jetpack" = "adblock-for-firefox";
      };
    };

    # User Profile Configuration
    profiles."${username}" = {
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

      # User-defined extensions
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

  # MIME Associations for Zen Browser
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
