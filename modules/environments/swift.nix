{ inputs, ... }:
let
  module = {
    perSystem =
      { pkgs, ... }:
      {
        shellEnvs.swift = {
          packages = with pkgs; [
            swift
            swiftpm
            swiftpm2nix
            sourcekit-lsp
          ];
          mkShellOverrides = {
            stdenv = pkgs.stdenv;
          };
        };
        treefmt.programs = {
          swift-format.enable = true;
        };
      };
  };

  component = {
    inherit module;
    dependencies = with inputs.flake.components; [
      nixology.extra.shellEnvs
    ];
  };
in
{
  imports = [ module ];
  flake.components = {
    nixology.environments.swift = component;
  };
}
