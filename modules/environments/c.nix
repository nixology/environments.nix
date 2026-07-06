{ ... }@local:
let
  inherit (local.inputs.flake.components) nixology;

  implementation = {
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
  imports = [
    implementation
  ];

  flake.components = {
    nixology.environments.c = {
      inherit implementation;

      dependencies = [
        nixology.extra.shellEnvironments
      ];

      meta = {
        description = "Provide C development tooling through a named shell environment.";
        shortDescription = "C development environment";
      };
    };
  };
}
