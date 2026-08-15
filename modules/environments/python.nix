{ inputs, lib, ... }:
let
  module = {
    perSystem = { pkgs, ... }: {
      shellEnvironments = {
        python = {
          packages = with pkgs; [
            black
            pyright
            python3
            ruff
          ];
        };
      };

      treefmt.programs = {
        black.enable = lib.mkDefault true;
        ruff-format.enable = lib.mkDefault true;
      };
    };
  };
in
{
  imports = [ module ];

  flake.components = {
    nixology.environments.python = {
      inherit module;

      dependencies = with inputs.flake.components; [
        nixology.extra.shellEnvironments
        nixology.tools.treefmt
      ];

      meta = {
        description = "Provide Python development tooling, Black formatting, and Ruff formatting.";
        shortDescription = "Python development environment";
      };
    };
  };
}
