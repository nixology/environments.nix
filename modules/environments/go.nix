{ inputs, ... }:
let
  module = {
    perSystem =
      {
        lib,
        pkgs,
        ...
      }:
      {
        shellEnvs.go = {
          packages = with pkgs; [
            go
            gotools
            golangci-lint
          ];
        };
        treefmt.programs = {
          goimports.enable = lib.mkDefault true;
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
    nixology.environments.go = component;
  };
}
