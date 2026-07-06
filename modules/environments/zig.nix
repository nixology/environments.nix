{ ... }@local:
let
  inherit (local.inputs.flake.components) nixology;

  implementation = {
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
  imports = [
    implementation
  ];

  flake.components = {
    nixology.environments.zig = {
      inherit implementation;

      dependencies = [
        nixology.extra.shellEnvironments
      ];

      meta = {
        description = "Provide Zig development tooling through a named shell environment.";
        shortDescription = "Zig development environment";
      };
    };
  };
}
