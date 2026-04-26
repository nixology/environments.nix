{ inputs, ... }:
let
  module = {
    perSystem =
      { lib, pkgs, ... }:
      {
        shellEnvs.java = {
          packages = with pkgs; [
            gradle
            jdk
            maven
          ];
        };
        treefmt.programs = {
          google-java-format.enable = lib.mkDefault true;
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
    nixology.environments.java = component;
  };
}
