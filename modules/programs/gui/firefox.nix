{
  lib,
  config,
  pkgs,
  ...
}: {
  options.cute.programs.gui.firefox = lib.mkEnableOption "";
  config = lib.mkIf config.cute.programs.gui.firefox {
    programs.firefox = {
      enable = true;
      package = pkgs.firefox-wayland.override {cfg.speechSynthesisSupport = false;};
      preferences = {
        "browser.aboutConfig.showWarning" = false;
        "browser.EULA.override" = true;
        "gfx.webrender.all" = true;
        "privacy.firstparty.isolate" = true;
      };
      policies = {
        CaptivePortal = false;
        DisableFeedbackCommands = true;
        DisableFirefoxAccounts = true;
        DisableFirefoxScreenshots = true;
        DisableFirefoxStudies = true;
        DisablePocket = true;
        DisableSetDesktopBackground = true;
        DisableTelemetry = true;
        DontCheckDefaultBrowser = true;
        HardwareAcceleration = true;
        NoDefaultBookmarks = true;
        PasswordManagerEnabled = false;
        Cookies = {
          Behavior = "accept";
          Locked = false;
        };
        FirefoxHome = {
          Highlights = false;
          Pocket = false;
          Snippets = false;
          TopSites = false;
          Locked = true;
        };
        FirefoxSuggest = {
          ImproveSuggest = false;
          SponsoredSuggestions = false;
          WebSuggestions = true;
          Locked = true;
        };
        UserMessaging = {
          ExtensionRecommendations = false;
          SkipOnboarding = true;
        };
        Bookmarks = let
          c = {
            Title = "";
            Placement = "toolbar";
          };
        in [
          ({URL = "https://discord.com/channels/@me";} // c)
          ({URL = "https://ciny.pagu.cafe";} // c)
          ({URL = "https://link.pagu.cafe/bookmarks";} // c)
        ];
        ExtensionSettings = let
          l = "https://addons.mozilla.org/firefox/downloads/latest/";
          x = "/latest.xpi";
          c = {
            default_area = "menupanel";
            installation_mode = "force_installed";
            updates_disabled = false;
          };
        in {
          "{446900e4-71c2-419f-a6a7-df9c091e268b}" =
            {install_url = "${l}bitwarden-password-manager${x}";} // c;
          "{61a05c39-ad45-4086-946f-32adb0a40a9d}" =
            {install_url = "${l}linkding-extension${x}";} // c;
          "{762f9885-5a13-4abd-9c77-433dcd38b8fd}" =
            {install_url = "${l}return-youtube-dislikes${x}";} // c;
          "sponsorBlocker@ajay.app" =
            {install_url = "${l}sponsorblock${x}";} // c;
          "treestyletab@piro.sakura.ne.jp" =
            {install_url = "${l}tree-style-tab${x}";} // c;
          "uBlock0@raymondhill.net" =
            {install_url = "${l}ublock-origin${x}";} // c;
          "{30280527-c46c-4e03-bb16-2e3ed94fa57c}" =
            {install_url = "${l}protondb-for-steam${x}";} // c;
          "{1be309c5-3e4f-4b99-927d-bb500eb4fa88}" =
            {install_url = "${l}augmented-steam${x}";} // c;
        };
      };
    };
    home.file."profiles" = {
      target = ".mozilla/firefox/profiles.ini";
      source = (pkgs.formats.ini {}).generate "profiles.ini" {
        General = {
          StartWithLastProfile = 1;
          Version = 2;
        };
        Profile0 = {
          Default = 1;
          IsRelative = 1;
          Name = "pagu";
          Path = "pagu";
        };
      };
    };
    hardware.opengl.extraPackages = builtins.attrValues {
      inherit (pkgs) vaapiVdpau libvdpau-va-gl;
    };
    environment.sessionVariables.MOZ_ENABLE_WAYLAND = "1";
  };
}
