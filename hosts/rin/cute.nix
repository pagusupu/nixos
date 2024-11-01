{
  pkgs,
  inputs,
  ...
}: {
  cute = {
    desktop = {
      misc = {
        audio = true;
        boot = true;
        fonts = true;
        gtk = true;
        xdg = true;
      };
      de = "hyprland";
    };
    programs = {
      cli = {
        btop = true;
        nvim = true;
        starship = true;
        zsh = true;
      };
      gui = {
        aagl = true;
        alacritty = true;
        discord = true;
        floorp = true;
        prismlauncher = true;
        steam = true;
      };
    };
    services = {
      backend.home-manager = true;
      local.glance = true;
      tailscale.enable = true;
    };
    system = {
      graphics = true;
      winDualBoot = true;
    };
    net.connection = "wireless";
  };
  networking = {
    hostName = "rin";
    hostId = "6f257938";
  };
  environment.systemPackages = with pkgs; [
    easyeffects
    heroic
    radeontop
    sublime-music
    xfce.thunar
  ];
  imports = [inputs.lix.nixosModules.default];
}
