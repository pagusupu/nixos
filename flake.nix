{
  inputs = {
    aagl = {
      url = "github:ezKEa/aagl-gtk-on-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    agenix-rekey = {
      url = "github:oddlama/agenix-rekey";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    lix = {
      url = "https://git.lix.systems/lix-project/nixos-module/archive/2.91.0.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    qbit.url = "github:fsnkty/nixpkgs?ref=init-nixos-qbittorrent";
    treefmt.url = "github:numtide/treefmt-nix";
  };
  outputs = {systems, ...} @ inputs:
    inputs.flake-parts.lib.mkFlake {inherit inputs;} {
      perSystem.treefmt.config = {
        programs = {
          alejandra.enable = true;
          deadnix.enable = true;
          statix.enable = true;
        };
        projectRootFile = "flake.nix";
      };
      imports = [./hosts inputs.treefmt.flakeModule];
      systems = ["x86_64-linux"];
    };
}
