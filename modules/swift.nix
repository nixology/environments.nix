{ inputs, ... }:
let
  module = {
    perSystem = { pkgs, ... }: with pkgs; let
      packages = [ swift swiftpm swiftpm2nix sourcekit-lsp ];
    in {
      shells.default = { inherit packages; };
      shells.swift = { inherit packages; };
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
  flake.components.nixology.environments.swift = component;
}
