local@{ ... }:
let
  implementation = {
    perSystem =
      { pkgs, ... }:
      {
        shellEnvs.scala.packages = [
          pkgs.metals
          pkgs.sbt
          pkgs.scala
        ];
      };
  };
in
{
  imports = [
    implementation
  ];

  flake.components = {
    nixology.environments.scala = {
      inherit implementation;

      dependencies = with local.inputs.flake.components; [
        nixology.extra.shellEnvs
      ];

      meta = {
        description = "Provide Scala development tooling through a named shell environment.";
        shortDescription = "Scala development environment";
      };
    };
  };
}
