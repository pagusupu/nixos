{
  pkgs,
  inputs,
  ...
}: {
  cute = {
    desktop = {
      audio = true;
      boot = true;
      de = "hyprland";
      fonts = true;
      gtk = true;
      misc.printing = true;
      xdg = true;
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
        nautilus = true;
        prismlauncher = true;
        steam = true;
        vscode = true;
      };
    };
    services = {
      backend.home-manager = true;
      local.glance = true;
      tailscale.enable = true;
    };
    system = {
      amd = true;
      graphics = true;
      winDualBoot = true;
    };
    net.connection = "wireless";
  };
  networking = {
    hostName = "rin";
    hostId = "6f257938";
  };
  security.sudo-rs.wheelNeedsPassword = false;
  home-manager.users.pagu.home.packages = with pkgs; [
    easyeffects
    feishin
    heroic
    kdePackages.okular
    radeontop
  ];
  imports = [inputs.lix.nixosModules.default];
}
