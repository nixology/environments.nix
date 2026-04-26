{ inputs, ... }:
let
  module = {
    perSystem =
      { lib, pkgs, ... }:
      {
        shellEnvs.rust = {
          packages = with pkgs; [
            cargo
            clippy
            rust-analyzer
            rustc
            rustfmt
          ];
        };
        treefmt.programs = {
          rustfmt.enable = lib.mkDefault true;
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
    nixology.environments.rust = component;
  };
}
