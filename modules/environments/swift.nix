{ inputs, ... }:
let
  module = {
    perSystem =
      { pkgs, ... }:
      let
        env = {
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
      in
      {
        environments.swift = env;
      };
  };

  component = {
    inherit module;
    dependencies = with inputs.flake.components; [
      nixology.extra.environments
    ];
  };
in
{
  imports = [ module ];
  flake.components = {
    nixology.environments.swift = component;
  };
}
