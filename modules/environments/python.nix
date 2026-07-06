{ ... }@local:
let
  inherit (local.inputs.flake.components) nixology;

  inherit (local.lib) mkDefault;

  implementation = {
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
        black.enable = mkDefault true;
        ruff-format.enable = mkDefault true;
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

      dependencies = [
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
