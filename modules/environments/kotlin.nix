{ ... }@local:
let
  inherit (local.inputs.flake.components) nixology;

  implementation = {
    perSystem = { pkgs, ... }: {
      shellEnvironments = {
        kotlin = {
          packages = with pkgs; [
            gradle
            kotlin
            kotlin-language-server
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
    nixology.environments.kotlin = {
      inherit implementation;

      dependencies = [
        nixology.extra.shellEnvironments
      ];

      meta = {
        description = "Provide Kotlin development tooling through a named shell environment.";
        shortDescription = "Kotlin development environment";
      };
    };
  };
}
