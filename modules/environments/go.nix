{ inputs, ... }:
let
  module = {
    perSystem =
      {
        config,
        lib,
        pkgs,
        ...
      }:
      let
        env = {
          packages =
            with pkgs;
            [
              go
              gotools
              golangci-lint
            ]
            ++ (with config.treefmt; [ build.wrapper ] ++ (builtins.attrValues build.programs));
        };
      in
      {
        environments.go = env;
        treefmt.programs.goimports.enable = lib.mkDefault true;
      };
  };

  component = {
    inherit module;
    dependencies = with inputs.flake.components; [
      nixology.extra.environments
      nixology.tools.treefmt
    ];
  };
in
{
  imports = [ module ];
  flake.components = {
    nixology.environments.go = component;
  };
}
