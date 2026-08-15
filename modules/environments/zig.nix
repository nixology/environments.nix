{ inputs, ... }:
let
  module = {
    perSystem = { pkgs, ... }: {
      shellEnvironments = {
        zig = {
          packages = with pkgs; [
            zig
            zls
          ];
        };
      };
    };
  };
in
{
  imports = [ module ];

  flake.components = {
    nixology.environments.zig = {
      inherit module;

      dependencies = with inputs.flake.components; [ nixology.extra.shellEnvironments ];

      meta = {
        description = "Provide Zig development tooling through a named shell environment.";
        shortDescription = "Zig development environment";
      };
    };
  };
}
