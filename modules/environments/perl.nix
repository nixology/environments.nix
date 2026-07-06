{ ... }@local:
let
  inherit (local.inputs.flake.components) nixology;

  implementation = {
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
  imports = [
    implementation
  ];

  flake.components = {
    nixology.environments.perl = {
      inherit implementation;

      dependencies = [
        nixology.extra.shellEnvironments
      ];

      meta = {
        description = "Provide Perl development tooling through a named shell environment.";
        shortDescription = "Perl development environment";
      };
    };
  };
}
