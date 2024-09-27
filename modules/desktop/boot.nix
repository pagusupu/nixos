{
  config,
  lib,
  cutelib,
  pkgs,
  ...
}: {
  options.cute.desktop.boot = cutelib.mkEnable;
  config = lib.mkIf config.cute.desktop.boot {
    systemd = {
      services.systemd-udev-settle.enable = false;
      network.wait-online.enable = false;
    };
    boot = {
      plymouth = {
        enable = true;
        theme = "bgrt";
        themePackages = [pkgs.nixos-bgrt-plymouth];
      };
      initrd.verbose = false;
      kernelParams = ["quiet" "splash"];
    };
    security.sudo.wheelNeedsPassword = false;
  };
}
