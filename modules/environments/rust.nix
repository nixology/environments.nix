local@{ ... }:
let
  inherit (local.lib)
    mkDefault
    ;

  implementation = {
    perSystem =
      { pkgs, ... }:
      {
        shellEnvs.rust.packages = [
          pkgs.cargo
          pkgs.cargo-audit
          pkgs.clippy
          pkgs.rust-analyzer
          pkgs.rustc
          pkgs.rustfmt
        ];

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

      dependencies = with local.inputs.flake.components; [
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
