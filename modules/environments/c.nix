{ inputs, ... }:
let
  implementation = {
    perSystem =
      { pkgs, ... }:
      {
        shellEnvs.c.packages = [
          pkgs.clang-tools
          pkgs.cmake
          pkgs.gcc
          pkgs.gdb
          pkgs.gnumake
          pkgs.pkg-config
        ];
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

      dependencies = with inputs.flake.components; [
        nixology.extra.shellEnvs
      ];

      meta = {
        description = "Provide C development tooling through a named shell environment.";
        shortDescription = "C development environment";
      };
    };
  };
}
