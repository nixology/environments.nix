{ inputs, ... }:
let
  module = {
    perSystem =
      { pkgs, ... }:
      {
        shellEnvs.kotlin = {
          packages = with pkgs; [
            gradle
            kotlin
            kotlin-language-server
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
    nixology.environments.kotlin = component;
  };
}
