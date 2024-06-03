{
  config,
  lib,
  ...
}:
lib.mkIf (config.cute.themes.name == "rose-pine") {
  _module.args.colours = {
    dark = {
      base = "232136";
      surface = "2a273f";
      overlay = "393552";
      muted = "6e6a86";
      subtle = "908caa";
      text = "e0def4";
      love = "eb6f92";
      gold = "f6c177";
      rose = "ebbcba";
      pine = "31748f";
      foam = "9ccfd8";
      iris = "c4a7e7";
      highlight = "56526e";
    };
    light = {
      base = "faf4ed";
      surface = "fffaf3";
      overlay = "f2e9e1";
      muted = "9893a5";
      subtle = "797593";
      text = "575279";
      love = "b4637a";
      gold = "ea9e34";
      rose = "d7827e";
      pine = "286983";
      foam = "56949f";
      iris = "907aa9";
      highlight = "cecacd";
    };
  };
  scheme = lib.mkDefault scheme/light.yaml;
  specialisation.dark.configuration = {
    environment.etc."specialisation".text = "dark";
    boot.loader.grub.configurationName = "dark";
    scheme = scheme/dark.yaml;
  };
}
