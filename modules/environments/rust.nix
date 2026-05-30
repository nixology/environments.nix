{ inputs, ... }:
let
  implementation = {
    perSystem =
      { lib, pkgs, ... }:
      {
        shellEnvs.rust.packages = [
          pkgs.cargo
          pkgs.cargo-audit
          pkgs.clippy
          pkgs.rust-analyzer
          pkgs.rustc
          pkgs.rustfmt
        ];

        treefmt.programs.rustfmt.enable = lib.mkDefault true;
      };
  };
in
{
  imports = [
    implementation
  ];

  flake.components = {
    nixology.environments.rust = {
      inherit implementation;

      dependencies = with inputs.flake.components; [
        nixology.extra.shellEnvs
        nixology.tools.treefmt
      ];

      meta = {
        description = "Provide Rust development tooling and rustfmt formatting.";
        shortDescription = "Rust development environment";
      };
    };
  };
}
