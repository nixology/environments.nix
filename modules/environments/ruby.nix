{ inputs, ... }:
let
  module = {
    perSystem =
      { lib, pkgs, ... }:
      {
        shellEnvs.ruby = {
          packages = with pkgs; [
            ruby
            rubyPackages.rubocop
          ];
        };
        treefmt.programs = {
          rubocop.enable = lib.mkDefault true;
        };
      };
  };

  component = {
    inherit module;
    dependencies = with inputs.flake.components; [
      nixology.extra.shellEnvs
      nixology.tools.treefmt
    ];
  };
in
{
  imports = [ module ];
  flake.components = {
    nixology.environments.ruby = component;
  };
}
