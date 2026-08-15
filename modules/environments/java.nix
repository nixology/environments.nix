{ inputs, lib, ... }:
let
  module = {
    perSystem = { pkgs, ... }: {
      shellEnvironments = {
        java = {
          packages = with pkgs; [
            gradle
            jdk
            maven
          ];
        };
      };

      treefmt.programs.google-java-format.enable = lib.mkDefault true;
    };
  };
in
{
  imports = [ module ];

  flake.components = {
    nixology.environments.java = {
      inherit module;

      dependencies = with inputs.flake.components; [
        nixology.extra.shellEnvironments
        nixology.tools.treefmt
      ];

      meta = {
        description = "Provide Java development tooling and google-java-format formatting.";
        shortDescription = "Java development environment";
      };
    };
  };
}
