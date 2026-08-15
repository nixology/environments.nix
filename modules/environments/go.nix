{ inputs, lib, ... }:
let
  module = {
    perSystem = { pkgs, ... }: {
      shellEnvironments = {
        go = {
          packages = with pkgs; [
            go
            gotools
            golangci-lint
          ];
        };
      };

      treefmt.programs.goimports.enable = lib.mkDefault true;
    };
  };
in
{
  imports = [ module ];

  flake.components = {
    nixology.environments.go = {
      inherit module;

      dependencies = with inputs.flake.components; [
        nixology.extra.shellEnvironments
        nixology.tools.treefmt
      ];

      meta = {
        description = "Provide Go development tooling and goimports formatting.";
        shortDescription = "Go development environment";
      };
    };
  };
}
