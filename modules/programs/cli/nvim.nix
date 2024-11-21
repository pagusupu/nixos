{
  config,
  lib,
  cutelib,
  inputs,
  pkgs,
  ...
}: {
  imports = [inputs.nixvim.nixosModules.nixvim];
  options.cute.programs.cli.nvim = cutelib.mkEnable;
  config = lib.mkIf config.cute.programs.cli.nvim {
    programs.nixvim = {
      enable = true;
      colorschemes.rose-pine = {
        enable = true;
        package = pkgs.rose-pine-nvim;
        settings = {
          styles = {
            italic = false;
            transparency = false;
          };
          variant = "auto";
        };
      };
      opts = {
        number = true;
        showmode = false;
        shiftwidth = 2;
        smartindent = true;
        termguicolors = true;
        undofile = true;
      };
      performance.byteCompileLua = {
        enable = true;
        nvimRuntime = true;
      };
      plugins = {
        indent-blankline = {
          enable = true;
          settings.scope.enabled = false;
        };
        lsp = {
          enable = true;
          servers = {
            nil_ls = {
              enable = true;
              settings = {
                formatting.command = ["${lib.getExe pkgs.alejandra}"];
                nix.flake.autoArchive = false;
              };
            };
            cssls.enable = true;
            html.enable = true;
            jsonls.enable = true;
          };
        };
        notify = {
          enable = true;
          render = "minimal";
          stages = "fade";
          timeout = 2000;
        };
        treesitter = {
          enable = true;
          settings.highlight.enable = true;
        };
        autoclose.enable = true;
        lualine.enable = true;
        lsp-format.enable = true;
        lsp-lines.enable = true;
        markview.enable = true;
        noice.enable = true;
        rainbow-delimiters.enable = true;
      };
      extraConfigVim = ''
        aun PopUp.How-to\ disable\ mouse
        aun PopUp.-1-
      '';
      enableMan = false;
      defaultEditor = true;
      luaLoader.enable = true;
      vimAlias = true;
      withPython3 = false;
      withRuby = false;
    };
    environment.variables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
    };
  };
}
