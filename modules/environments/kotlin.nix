{ inputs, ... }:
let
  module = {
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
  imports = [ module ];

  flake.components = {
    nixology.environments.kotlin = {
      inherit module;

      dependencies = with inputs.flake.components; [ nixology.extra.shellEnvironments ];

      meta = {
        description = "Provide Kotlin development tooling through a named shell environment.";
        shortDescription = "Kotlin development environment";
      };
    };
  };
}
