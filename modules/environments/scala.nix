{ inputs, ... }:
let
  module = {
    perSystem = { pkgs, ... }: {
      shellEnvironments = {
        scala = {
          packages = with pkgs; [
            metals
            sbt
            scala
          ];
        };
      };
    };
  };
in
{
  imports = [ module ];

  flake.components = {
    nixology.environments.scala = {
      inherit module;

      dependencies = with inputs.flake.components; [ nixology.extra.shellEnvironments ];

      meta = {
        description = "Provide Scala development tooling through a named shell environment.";
        shortDescription = "Scala development environment";
      };
    };
  };
}
