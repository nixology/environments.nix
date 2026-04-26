{ inputs, ... }:
let
  module = {
    perSystem =
      { lib, pkgs, ... }:
      {
        shellEnvs.python = {
          packages = with pkgs; [
            black
            pyright
            python3
            ruff
          ];
        };
        treefmt.programs = {
          black.enable = lib.mkDefault true;
          ruff-format.enable = lib.mkDefault true;
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
    nixology.environments.python = component;
  };
}
