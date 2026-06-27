local@{ ... }:
let
  implementation = {
    perSystem =
      { pkgs, ... }:
      {
        shellEnvs.r.packages = [
          pkgs.R
          pkgs.rPackages.languageserver
        ];
      };
  };
in
{
  imports = [
    implementation
  ];

  flake.components = {
    nixology.environments.r = {
      inherit implementation;

      dependencies = with local.inputs.flake.components; [
        nixology.extra.shellEnvs
      ];

      meta = {
        description = "Provide R development tooling through a named shell environment.";
        shortDescription = "R development environment";
      };
    };
  };
}
