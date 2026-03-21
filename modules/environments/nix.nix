{ inputs, ... }:
let
  module = {
    perSystem =
      { pkgs, ... }:
      let
        env = {
          packages = with pkgs; [ nix-output-monitor ];
        };
      in
      {
        environments.nix = env;
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
    nixology.environments.nix = component;
  };
}
