{ inputs, lib, ... }:
let
  module = {
    perSystem = { pkgs, ... }: {
      shellEnvironments = {
        ruby = {
          packages = with pkgs; [
            ruby
            rubyPackages.rubocop
          ];
        };
      };

      treefmt.programs.rubocop.enable = lib.mkDefault true;
    };
  };
in
{
  imports = [ module ];

  flake.components = {
    nixology.environments.ruby = {
      inherit module;

      dependencies = with inputs.flake.components; [
        nixology.extra.shellEnvironments
        nixology.tools.treefmt
      ];

      meta = {
        description = "Provide Ruby development tooling and RuboCop formatting.";
        shortDescription = "Ruby development environment";
      };
    };
  };
}
