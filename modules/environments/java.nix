{ inputs, ... }:
let
  implementation = {
    perSystem =
      { lib, pkgs, ... }:
      {
        shellEnvs.java.packages = [
          pkgs.gradle
          pkgs.jdk
          pkgs.maven
        ];

        treefmt.programs.google-java-format.enable = lib.mkDefault true;
      };
  };
in
{
  imports = [
    implementation
  ];

  flake.components = {
    nixology.environments.java = {
      inherit implementation;

      dependencies = with inputs.flake.components; [
        nixology.extra.shellEnvs
        nixology.tools.treefmt
      ];

      meta = {
        description = "Provide Java development tooling and google-java-format formatting.";
        shortDescription = "Java development environment";
      };
    };
  };
}
