local@{ ... }:
let
  implementation = {
    perSystem =
      { pkgs, ... }:
      {
        shellEnvs.dart.packages = [
          pkgs.dart
        ];
      };
  };
in
{
  imports = [
    implementation
  ];

  flake.components = {
    nixology.environments.dart = {
      inherit implementation;

      dependencies = with local.inputs.flake.components; [
        nixology.extra.shellEnvs
      ];

      meta = {
        description = "Provide Dart development tooling through a named shell environment.";
        shortDescription = "Dart development environment";
      };
    };
  };
}
