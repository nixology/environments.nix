{ inputs, ... }:
let
  implementation = {
    perSystem =
      { pkgs, ... }:
      {
        shellEnvs.kotlin.packages = [
          pkgs.gradle
          pkgs.kotlin
          pkgs.kotlin-language-server
        ];
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

      dependencies = with inputs.flake.components; [
        nixology.extra.shellEnvs
      ];

      meta = {
        description = "Provide Kotlin development tooling through a named shell environment.";
        shortDescription = "Kotlin development environment";
      };
    };
  };
}
