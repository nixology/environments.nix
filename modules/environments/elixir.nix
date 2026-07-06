{ ... }@local:
let
  inherit (local.inputs.flake.components) nixology;

  implementation = {
    perSystem = { pkgs, ... }: {
      shellEnvironments = {
        elixir = {
          packages = with pkgs; [
            elixir
            elixir-ls
          ];
        };
      };
    };
  };
in
{
  imports = [
    implementation
  ];

  flake.components = {
    nixology.environments.elixir = {
      inherit implementation;

      dependencies = [
        nixology.extra.shellEnvironments
      ];

      meta = {
        description = "Provide Elixir development tooling through a named shell environment.";
        shortDescription = "Elixir development environment";
      };
    };
  };
}
