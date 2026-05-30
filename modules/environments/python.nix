{ inputs, ... }:
let
  implementation = {
    perSystem =
      { lib, pkgs, ... }:
      {
        shellEnvs.python.packages = [
          pkgs.black
          pkgs.pyright
          pkgs.python3
          pkgs.ruff
        ];

        treefmt.programs = {
          black.enable = lib.mkDefault true;
          ruff-format.enable = lib.mkDefault true;
        };
      };
  };
in
{
  imports = [
    implementation
  ];

  flake.components = {
    nixology.environments.python = {
      inherit implementation;

      dependencies = with inputs.flake.components; [
        nixology.extra.shellEnvs
        nixology.tools.treefmt
      ];

      meta = {
        description = "Provide Python development tooling, Black formatting, and Ruff formatting.";
        shortDescription = "Python development environment";
      };
    };
  };
}
