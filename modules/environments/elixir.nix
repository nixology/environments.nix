{ inputs, ... }:
let
  module = {
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
  imports = [ module ];

  flake.components = {
    nixology.environments.elixir = {
      inherit module;

      dependencies = with inputs.flake.components; [ nixology.extra.shellEnvironments ];

      meta = {
        description = "Provide Elixir development tooling through a named shell environment.";
        shortDescription = "Elixir development environment";
      };
    };
  };
}
