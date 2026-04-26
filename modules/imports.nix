{ inputs, ... }:
{
  imports =
    with inputs.flake.components;
    map (component: component.module) [
      nixology.core.components
      nixology.environments.nix
      nixology.extra.shellEnvs
      nixology.tools.treefmt
      nixology.pkgs.unstable
    ];
}
