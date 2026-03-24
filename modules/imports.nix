{ inputs, ... }:
{
  imports =
    with inputs.flake.components;
    map (component: component.module) [
      nixology.extra.shells
      nixology.std.components
      nixology.tools.treefmt
    ];
}
