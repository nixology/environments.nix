{ inputs, ... }:
let
  implementation = {
    perSystem =
      { lib, pkgs, ... }:
      {
        shellEnvs.ruby.packages = [
          pkgs.ruby
          pkgs.rubyPackages.rubocop
        ];

        treefmt.programs.rubocop.enable = lib.mkDefault true;
      };
  };
in
{
  imports = [
    implementation
  ];

  flake.components = {
    nixology.environments.ruby = {
      inherit implementation;

      dependencies = with inputs.flake.components; [
        nixology.extra.shellEnvs
        nixology.tools.treefmt
      ];

      meta = {
        description = "Provide Ruby development tooling and RuboCop formatting.";
        shortDescription = "Ruby development environment";
      };
    };
  };
}
