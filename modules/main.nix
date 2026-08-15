{ inputs, ... }:
let
  inherit (inputs.flake.lib.components) implementationsOf;
in
{
  imports = implementationsOf (
    with inputs.flake.components;
    [
      nixology.core.components
      nixology.environments.nix
      nixology.extra.shellEnvironments
      nixology.tools.treefmt
    ]
  );
}
