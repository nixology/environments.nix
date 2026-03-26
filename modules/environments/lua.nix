{ inputs, ... }:
let
  module = {
    perSystem =
      { lib, pkgs, ... }:
      {
        shellEnvs.lua = {
          packages = with pkgs; [ lua5_1 ];
        };
        treefmt.programs = {
          stylua.enable = lib.mkDefault true;
        };
      };
  };

  component = {
    inherit module;
    dependencies = with inputs.flake.components; [
      nixology.extra.shellEnvs
      nixology.tools.treefmt
    ];
  };
in
{
  imports = [ module ];
  flake.components = {
    nixology.environments.lua = component;
  };
}
