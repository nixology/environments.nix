{ inputs, ... }:
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

      dependencies = with inputs.flake.components; [
        nixology.extra.shellEnvs
      ];

      meta = {
        description = "Provide Erlang development tooling through a named shell environment.";
        shortDescription = "Erlang development environment";
      };
    };
  };
}
