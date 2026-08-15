{ inputs, ... }:
let
  module = {
    perSystem = { pkgs, ... }: {
      shellEnvironments = {
        r = {
          packages = with pkgs; [
            R
            rPackages.languageserver
          ];
        };
      };
    };
  };
in
{
  imports = [ module ];

  flake.components = {
    nixology.environments.r = {
      inherit module;

      dependencies = with inputs.flake.components; [ nixology.extra.shellEnvironments ];

      meta = {
        description = "Provide R development tooling through a named shell environment.";
        shortDescription = "R development environment";
      };
    };
  };
}
