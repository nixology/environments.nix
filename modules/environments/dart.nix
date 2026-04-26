{ inputs, ... }:
let
  module = {
    perSystem =
      { pkgs, ... }:
      {
        shellEnvs.dart = {
          packages = with pkgs; [
            dart
          ];
        };
      };
  };

  component = {
    inherit module;
    dependencies = with inputs.flake.components; [
      nixology.extra.shellEnvs
    ];
  };
in
{
  imports = [ module ];
  flake.components = {
    nixology.environments.dart = component;
  };
}
