{ inputs, lib, ... }:
let
  module = {
    perSystem = { pkgs, ... }: {
      shellEnvironments = {
        lua = {
          packages = with pkgs; [
            lua5_1
          ];
        };
      };

      treefmt.programs.stylua.enable = lib.mkDefault true;
    };
  };
in
{
  imports = [ module ];

  flake.components = {
    nixology.environments.lua = {
      inherit module;

      dependencies = with inputs.flake.components; [
        nixology.extra.shellEnvironments
        nixology.tools.treefmt
      ];

      meta = {
        description = "Provide Lua development tooling and StyLua formatting.";
        shortDescription = "Lua development environment";
      };
    };
  };
}
