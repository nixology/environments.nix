local@{ ... }:
let
  inherit (local.lib)
    mkDefault
    ;

  implementation = {
    perSystem =
      { pkgs, ... }:
      {
        shellEnvs.java.packages = [
          pkgs.gradle
          pkgs.jdk
          pkgs.maven
        ];

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

      dependencies = with local.inputs.flake.components; [
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
