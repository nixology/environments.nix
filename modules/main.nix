{ inputs, lib, ... }: {
  imports = lib.components.implementationsFrom (
    with inputs.flake.components;
    [
      nixology.core.components
      nixology.environments.nix
      nixology.extra.shellEnvironments
      nixology.tools.treefmt
    ]
  );
}
