{ inputs, ... }:
let
  implementation = {
    perSystem =
      { pkgs, ... }:
      {
        shellEnvs.zig.packages = [
          pkgs.zig
          pkgs.zls
        ];
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

      dependencies = with inputs.flake.components; [
        nixology.extra.shellEnvs
      ];

      meta = {
        description = "Provide Zig development tooling through a named shell environment.";
        shortDescription = "Zig development environment";
      };
    };
  };
}
