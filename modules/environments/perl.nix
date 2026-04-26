{ inputs, ... }:
let
  module = {
    perSystem =
      { pkgs, ... }:
      {
        shellEnvs.perl = {
          packages = with pkgs; [
            perl
            perlPackages.PerlCritic
            perlPackages.PerlTidy
          ];
        };
      };
  };

  component = {
    inherit module;
    dependencies = with inputs.flake.components; [
      nixology.extra.shellEnvs
    ];
  };
in
{
  imports = [ module ];
  flake.components = {
    nixology.environments.perl = component;
  };
}
