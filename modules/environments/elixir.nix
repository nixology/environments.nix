{ inputs, ... }:
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

      dependencies = with inputs.flake.components; [
        nixology.extra.shellEnvs
      ];

      meta = {
        description = "Provide Elixir development tooling through a named shell environment.";
        shortDescription = "Elixir development environment";
      };
    };
  };
}
