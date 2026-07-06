{ ... }@local:
let
  inherit (local.inputs.flake.components) nixology;

  inherit (local.lib) mkDefault;

  implementation = {
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

      treefmt.programs.google-java-format.enable = mkDefault true;
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

      dependencies = [
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
