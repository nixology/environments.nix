{ ... }@local:
let
  inherit (local.inputs.flake.components) nixology;

  implementation = {
    perSystem = { pkgs, ... }: {
      shellEnvironments = {
        php = {
          packages = with pkgs; [
            php
            phpPackages.composer
            phpactor
          ];
        };
      };
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

      dependencies = [
        nixology.extra.shellEnvironments
      ];

      meta = {
        description = "Provide PHP development tooling through a named shell environment.";
        shortDescription = "PHP development environment";
      };
    };
  };
}
