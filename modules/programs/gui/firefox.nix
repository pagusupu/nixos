{
  config,
  lib,
  cutelib,
  pkgs,
  inputs,
  ...
}: {
  options.cute.programs.gui.firefox = cutelib.mkEnable;
  config = lib.mkIf config.cute.programs.gui.firefox {
    assertions = cutelib.assertHm "firefox";
    home-manager.users.pagu = {
      programs.firefox = {
        enable = true;
        package = pkgs.firefox.override {cfg.speechSynthesisSupport = false;};
        profiles.pagu = {
          extensions = with inputs.firefox-addons.packages.${pkgs.system}; [
            bitwarden
            darkreader
            linkding-extension
            return-youtube-dislikes
            sponsorblock
            stylus
            tree-style-tab
          ];
          settings = {
            "browser.startup.homepage" = "http://localhost:8333";
            "browser.aboutConfig.showWarning" = false;
            "browser.EULA.override" = true;
            "extensions.webextensions.restrictedDomains" = "";
            "gfx.webrender.all" = true;
            "privacy.firstparty.isolate" = true;
            "privacy.resistFingerprinting.block_mozAddonManager" = true;
          };
          search = {
            force = true;
            default = "DuckDuckGo";
            order = [
              "DuckDuckGo"
              "Google"
            ];
            engines = {
              "Amazon.com".metaData.hidden = true;
              "Bing".metaData.hidden = true;
              "eBay".metaData.hidden = true;
              "Wikipedia (en)".metaData.hidden = true;
            };
          };
          extraConfig = let
            betterfox = pkgs.fetchFromGitHub {
              owner = "yokoffing";
              repo = "Betterfox";
              rev = "129.0";
              hash = "sha256-hpkEO5BhMVtINQG8HN4xqfas/R6q5pYPZiFK8bilIDs=";
            };
            inherit (builtins) readFile;
          in ''
            ${readFile "${betterfox}/Fastfox.js"}
            ${readFile "${betterfox}/Peskyfox.js"}
            ${readFile "${betterfox}/Securefox.js"}
            ${readFile "${betterfox}/Smoothfox.js"}
          '';
        };
        policies = {
          DisableFeedbackCommands = true;
          DisableFirefoxAccounts = true;
          DisableFirefoxScreenshots = true;
          DisablePocket = true;
          DisableProfileImport = true;
          DisableProfileRefresh = true;
          DisableSetDesktopBackground = true;
          DisplayBookmarksToolbar = "never";
          HardwareAcceleration = true;
          NoDefaultBookmarks = true;
          PasswordManagerEnabled = false;
          Cookies = {
            Behavior = "reject-tracker-and-partition-foreign";
            Locked = true;
          };
          SanitizeOnShutdown = {
            Cache = false;
            Cookies = false;
            History = false;
            Sessions = true;
            SiteSettings = false;
            OfflineApps = true;
            Locked = true;
          };
          "3rdparty".Extensions = {
            "addon@darkreader.org" = {
              enabled = true;
              automation = {
                enabled = true;
                behavior = "OnOff";
                mode = "system";
              };
              detectDarkTheme = true;
              enabledByDefault = false;
              enableForProtectedPages = true;
              fetchNews = false;
              previewNewDesign = true;
              syncSettings = false;
            };
            "uBlock0@raymondhill.net" = {
              adminSettings.selectedFilterLists = [
                "user-filters"
                "ublock-filters"
                "ublock-badware"
                "ublock-privacy"
                "ublock-quick-fixes"
                "ublock-unbreak"
                "easylist"
                "easyprivacy"
                "adguard-spyware-url"
                "urlhaus-1"
                "plowe-0"
                "fanboy-cookiemonster"
                "ublock-cookies-easylist"
                "fanboy-social"
                "easylist-chat"
                "easylist-newsletters"
                "easylist-notifications"
                "easylist-annoyances"
                "ublock-annoyances"
                "https://raw.githubusercontent.com/DandelionSprout/adfilt/refs/heads/master/LegitimateURLShortener.txt"
                "https://raw.githubusercontent.com/laylavish/uBlockOrigin-HUGE-AI-Blocklist/main/list.txt"
              ];
            };
            userSettings.importedLists = [
              "https://raw.githubusercontent.com/DandelionSprout/adfilt/master/LegitimateURLShortener.txt"
              "https://raw.githubusercontent.com/laylavish/uBlockOrigin-HUGE-AI-Blocklist/main/list.txt"
            ];
          };
        };
      };
    };
    environment.sessionVariables.MOZ_ENABLE_WAYLAND = "1";
  };
}
