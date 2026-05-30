{ inputs, ... }:
let
  implementation = {
    perSystem =
      { pkgs, ... }:
      {
        shellEnvs.php.packages = [
          pkgs.php
          pkgs.phpPackages.composer
          pkgs.phpactor
        ];
      };
  };
in
{
  imports = [
    implementation
  ];

  flake.components = {
    nixology.environments.php = {
      inherit implementation;

      dependencies = with inputs.flake.components; [
        nixology.extra.shellEnvs
      ];

      meta = {
        description = "Provide PHP development tooling through a named shell environment.";
        shortDescription = "PHP development environment";
      };
    };
  };
}
