{
  config,
  lib,
  cutelib,
  pkgs,
  ...
}: {
  options.cute.programs.gui.steam = cutelib.mkEnable;
  config = lib.mkIf config.cute.programs.gui.steam (lib.mkMerge [
    {
      programs.steam = {
        enable = true;
        extest.enable = true;
        localNetworkGameTransfers.openFirewall = true;
        protontricks.enable = true;
        gamescopeSession = {
          enable = true;
          args = [
            "-H 1080"
            "-r 165"
            "-e"
            "--expose-wayland"
          ];
          env = {
            SDL_VIDEODRIVER = "x11";
            WLR_RENDERER = "vulkan";
          };
        };
        extraCompatPackages = [pkgs.proton-ge-bin];
      };
      hardware.xone.enable = true;
    }
    {
      programs.gamemode = {
        enable = true;
        enableRenice = true;
        settings = {
          gpu = {
            amd_performance_level = "high";
            apply_gpu_optimisations = "accept-responsibility";
            gpu_device = 0;
          };
          general.renice = 10;
        };
      };
      users.users.pagu.extraGroups = ["gamemode"];
    }
    {
      # https://github.com/fufexan/nix-gaming/blob/master/modules/platformOptimizations.nix
      boot.kernel.sysctl = {
        "kernel.sched_cfs_bandwidth_slice_us" = 3000;
        "net.ipv4.tcp_fin_timeout" = 5;
        "vm.max_map_count" = 2147483642;
      };
      environment.sessionVariables.WINEDEBUG = "-all";
    }
  ]);
}
