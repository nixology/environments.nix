local@{ ... }:
let
  implementation = {
    perSystem =
      { pkgs, ... }:
      {
        shellEnvs.elixir.packages = [
          pkgs.elixir
          pkgs.elixir-ls
        ];
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

      dependencies = with local.inputs.flake.components; [
        nixology.extra.shellEnvs
      ];

      meta = {
        description = "Provide Elixir development tooling through a named shell environment.";
        shortDescription = "Elixir development environment";
      };
    };
  };
}
