{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    devenv.url = "github:cachix/devenv";
  };

  outputs = inputs @ {
    nixpkgs,
    flake-parts,
    devenv,
    ...
  }:
    flake-parts.lib.mkFlake {inherit inputs;} {
      imports = [devenv.flakeModule];
      systems = ["x86_64-linux" "aarch64-darwin"];

      perSystem = {system, ...}: {
        devenv.shells.default = {
          languages.nix = {
            enable = true;
          };

          languages.lua = {
            enable = true;
          };

          git-hooks.hooks = {
            alejandra.enable = true;
            statix.enable = true;
            stylua.enable = true;
            luacheck.enable = true;
          };
        };
      };
    };
}
