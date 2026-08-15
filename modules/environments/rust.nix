{ inputs, lib, ... }:
let
  module = {
    perSystem = { pkgs, ... }: {
      shellEnvironments = {
        rust = {
          packages = with pkgs; [
            cargo
            cargo-audit
            clippy
            rust-analyzer
            rustc
            rustfmt
          ];
        };
      };

      treefmt.programs.rustfmt.enable = lib.mkDefault true;
    };
  };
in
{
  imports = [ module ];

  flake.components = {
    nixology.environments.rust = {
      inherit module;

      dependencies = with inputs.flake.components; [
        nixology.extra.shellEnvironments
        nixology.tools.treefmt
      ];

      meta = {
        description = "Provide Rust development tooling and rustfmt formatting.";
        shortDescription = "Rust development environment";
      };
    };
  };
}
