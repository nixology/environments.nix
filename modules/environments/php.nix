{ inputs, ... }:
let
  module = {
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
  imports = [ module ];

  flake.components = {
    nixology.environments.php = {
      inherit module;

      dependencies = with inputs.flake.components; [ nixology.extra.shellEnvironments ];

      meta = {
        description = "Provide PHP development tooling through a named shell environment.";
        shortDescription = "PHP development environment";
      };
    };
  };
}
