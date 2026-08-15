{ inputs, ... }:
let
  module = {
    perSystem = { pkgs, ... }: {
      shellEnvironments = {
        perl = {
          packages = with pkgs; [
            perl
            perlPackages.PerlCritic
            perlPackages.PerlTidy
          ];
        };
      };
    };
  };
in
{
  imports = [ module ];

  flake.components = {
    nixology.environments.perl = {
      inherit module;

      dependencies = with inputs.flake.components; [ nixology.extra.shellEnvironments ];

      meta = {
        description = "Provide Perl development tooling through a named shell environment.";
        shortDescription = "Perl development environment";
      };
    };
  };
}
