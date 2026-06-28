local@{ ... }:
let
  inherit (local.inputs.flake.lib.components) uses;
  inherit (local.inputs.flake.components) nixology;
in
uses {
  components = [
    nixology.core.components
    nixology.environments.nix
    nixology.extra.shellEnvs
    nixology.tools.treefmt
  ];
}
