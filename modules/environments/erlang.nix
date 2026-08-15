{ inputs, ... }:
let
  module = {
    perSystem = { pkgs, ... }: {
      shellEnvironments = {
        erlang = {
          packages = with pkgs; [
            erlang
            rebar3
          ];
        };
      };
    };
  };
in
{
  imports = [ module ];

  flake.components = {
    nixology.environments.erlang = {
      inherit module;

      dependencies = with inputs.flake.components; [ nixology.extra.shellEnvironments ];

      meta = {
        description = "Provide Erlang development tooling through a named shell environment.";
        shortDescription = "Erlang development environment";
      };
    };
  };
}
