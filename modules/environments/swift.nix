{ inputs, lib, ... }:
let
  module = {
    perSystem = { pkgs, ... }: {
      shellEnvironments = {
        swift = {
          packages = with pkgs; [
            swift
            swiftpm
            swiftpm2nix
            sourcekit-lsp
          ];

          mkShellOverrides.stdenv = pkgs.stdenv;
        };
      };

      treefmt.programs.swift-format.enable = lib.mkDefault true;
    };
  };
in
{
  imports = [ module ];

  flake.components = {
    nixology.environments.swift = {
      inherit module;

      dependencies = with inputs.flake.components; [
        nixology.extra.shellEnvironments
        nixology.tools.treefmt
      ];

      meta = {
        description = "Provide Swift development tooling and swift-format formatting.";
        shortDescription = "Swift development environment";
      };
    };
  };
}
