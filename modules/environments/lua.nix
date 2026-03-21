{ inputs, ... }:
let
  module = {
    perSystem =
      { pkgs, ... }:
      let
        env = {
          packages = with pkgs; [ lua5_1 ];
        };
      in
      {
        environments.lua = env;
      };
  };

  component = {
    inherit module;
    dependencies = with inputs.flake.components; [
      nixology.extra.environments
    ];
  };
in
{
  imports = [ module ];
  flake.components = {
    nixology.environments.lua = component;
  };
}
