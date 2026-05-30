{ inputs, ... }:
let
  implementation = {
    perSystem =
      { lib, pkgs, ... }:
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

        treefmt.programs.swift-format.enable = lib.mkDefault true;
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

      dependencies = with inputs.flake.components; [
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
