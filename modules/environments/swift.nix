{ inputs, ... }:
let
  module = {
    perSystem =
      { pkgs, ... }:
      let
        shell = {
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
        shells.swift = shell;
      };
  };

  component = {
    inherit module;
    dependencies = with inputs.flake.components; [
      nixology.extra.shells
    ];
  };
in
{
  imports = [ module ];
  flake.components = {
    nixology.environments.swift = component;
  };
}
