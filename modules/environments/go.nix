local@{ ... }:
let
  implementation = {
    perSystem = { pkgs, ... }: with local.lib;
      {
        shellEnvs.go.packages = [
          pkgs.go
          pkgs.gotools
          pkgs.golangci-lint
        ];

        treefmt.programs.goimports.enable = mkDefault true;
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

      dependencies = with local.inputs.flake.components; [
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
