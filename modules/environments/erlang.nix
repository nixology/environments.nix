local@{ ... }:
let
  implementation = {
    perSystem =
      { pkgs, ... }:
      {
        shellEnvs.erlang.packages = [
          pkgs.erlang
          pkgs.rebar3
        ];
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

      dependencies = with local.inputs.flake.components; [
        nixology.extra.shellEnvs
      ];

      meta = {
        description = "Provide Erlang development tooling through a named shell environment.";
        shortDescription = "Erlang development environment";
      };
    };
  };
}
