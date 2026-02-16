{ inputs, ... }:
let
  module = {
    perSystem = { pkgs, ... }: with pkgs; let
      packages = [ lua5_1 ];
    in {
      shells.default = { inherit packages; };
      shells.lua = { inherit packages; };
    };
  };

  component = {
    inherit module;
    dependencies = with inputs.parts; [
      components.nixology.parts.devShells
    ];
  };
in
{
  imports = [ module ];
  flake.components.nixology.environments.lua = component;
}
