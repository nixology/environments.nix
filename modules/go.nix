{ inputs, ... }:
let
  module = {
    perSystem = { pkgs, ... }: with pkgs; let
      packages = [ go gotools golangci-lint ];
    in {
      shells.default = { inherit packages; };
      shells.go = { inherit packages; };
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
  flake.components.nixology.environments.go = component;
}
