{ ... }@local:
let
  inherit (local.inputs.flake.components) nixology;

  implementation = {
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
  imports = [
    implementation
  ];

  flake.components = {
    nixology.environments.erlang = {
      inherit implementation;

      dependencies = [
        nixology.extra.shellEnvironments
      ];

      meta = {
        description = "Provide Erlang development tooling through a named shell environment.";
        shortDescription = "Erlang development environment";
      };
    };
  };
}
