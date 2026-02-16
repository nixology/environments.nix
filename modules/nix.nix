{ inputs, ... }:
let
  module = {
    perSystem = { pkgs, ... }: with pkgs; let
      packages = [ nix-output-monitor ];
    in {
      shells.default = { inherit packages; };
      shells.nix = { inherit packages; };
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
  flake.components.nixology.environments.nix = component;
}
