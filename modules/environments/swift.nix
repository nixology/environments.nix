local@{ ... }:
let
  implementation = {
    perSystem = { pkgs, ... }: with local.lib;
      {
        shellEnvs.swift = {
          packages = [
            pkgs.swift
            pkgs.swiftpm
            pkgs.swiftpm2nix
            pkgs.sourcekit-lsp
          ];

          mkShellOverrides.stdenv = pkgs.stdenv;
        };

        treefmt.programs.swift-format.enable = mkDefault true;
      };
  };
in
{
  imports = [
    implementation
  ];

  flake.components = {
    nixology.environments.swift = {
      inherit implementation;

      dependencies = with local.inputs.flake.components; [
        nixology.extra.shellEnvs
        nixology.tools.treefmt
      ];

      meta = {
        description = "Provide Swift development tooling and swift-format formatting.";
        shortDescription = "Swift development environment";
      };
    };
  };
}
