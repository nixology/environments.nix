{ inputs, ... }:
let
  implementation = {
    perSystem =
      { pkgs, ... }:
      {
        shellEnvs.perl.packages = [
          pkgs.perl
          pkgs.perlPackages.PerlCritic
          pkgs.perlPackages.PerlTidy
        ];
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

      dependencies = with inputs.flake.components; [
        nixology.extra.shellEnvs
      ];

      meta = {
        description = "Provide Perl development tooling through a named shell environment.";
        shortDescription = "Perl development environment";
      };
    };
  };
}
