{ ... }@local:
let
  inherit (local.inputs.flake.components) nixology;

  inherit (local.lib) mkDefault;

  implementation = {
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

      dependencies = [
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
