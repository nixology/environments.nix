{ inputs, ... }:
let
  module = {
    perSystem = { pkgs, ... }: {
      shellEnvironments = {
        c = {
          packages = with pkgs; [
            clang-tools
            cmake
            gcc
            gdb
            gnumake
            pkg-config
          ];
        };
      };
    };
  };
in
{
  imports = [ module ];

  flake.components = {
    nixology.environments.c = {
      inherit module;

      dependencies = with inputs.flake.components; [ nixology.extra.shellEnvironments ];

      meta = {
        description = "Provide C development tooling through a named shell environment.";
        shortDescription = "C development environment";
      };
    };
  };
}
