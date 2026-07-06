{ ... }@local:
let
  inherit (local.inputs.flake.components) nixology;

  inherit (local.lib) mkDefault;

  implementation = {
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

      dependencies = [
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
