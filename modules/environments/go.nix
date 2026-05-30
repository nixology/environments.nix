{ inputs, ... }:
let
  implementation = {
    perSystem =
      { lib, pkgs, ... }:
      {
        shellEnvs.go.packages = [
          pkgs.go
          pkgs.gotools
          pkgs.golangci-lint
        ];

        treefmt.programs.goimports.enable = lib.mkDefault true;
      };
  };
in
{
  imports = [
    implementation
  ];

  flake.components = {
    nixology.environments.go = {
      inherit implementation;

      dependencies = with inputs.flake.components; [
        nixology.extra.shellEnvs
        nixology.tools.treefmt
      ];

      meta = {
        description = "Provide Go development tooling and goimports formatting.";
        shortDescription = "Go development environment";
      };
    };
  };
}
