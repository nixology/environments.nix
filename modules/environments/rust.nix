{ ... }@local:
let
  inherit (local.inputs.flake.components) nixology;

  inherit (local.lib) mkDefault;

  implementation = {
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

      treefmt.programs.rustfmt.enable = mkDefault true;
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

      dependencies = [
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
