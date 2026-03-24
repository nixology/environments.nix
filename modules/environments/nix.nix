{ inputs, ... }:
let
  module = {
    perSystem =
      { pkgs, ... }:
      let
        shell = {
          packages = with pkgs; [ nix-output-monitor ];
        };
      in
      {
        shells.nix = shell;
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
    nixology.environments.nix = component;
  };
}
