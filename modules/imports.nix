{ inputs, ... }:
{
  imports =
    with inputs.flake.components;
    map (component: component.module) [
      nixology.extra.environments
      nixology.std.components
      nixology.std.debug
      nixology.std.lib
      nixology.tools.treefmt
    ];
}
