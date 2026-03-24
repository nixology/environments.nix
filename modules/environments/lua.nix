{ inputs, ... }:
let
  module = {
    perSystem =
      { pkgs, ... }:
      let
        shell = {
          packages = with pkgs; [ lua5_1 ];
        };
      in
      {
        shells.lua = shell;
      };
  };

  component = {
    inherit module;
    dependencies = with inputs.flake.components; [
      nixology.extra.shells
    ];
  };
in
{
  imports = [ module ];
  flake.components = {
    nixology.environments.lua = component;
  };
}
