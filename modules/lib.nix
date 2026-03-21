{ lib, ... }:
let
  library = {
    mkComposedEnvironment =
      {
        name,
        environments ? [ ],
        ...
      }:
      lib.mkMerge (
        (map (environment: { environments."${name}" = environment; }) environments)
        ++ [ { environments."${name}".name = lib.mkForce name; } ]
      );
  };

  module = {
    flake.lib = library;
  };

  component = {
    inherit module;
  };
in
{
  imports = [ module ];
  flake.components = {
    nixology.lib.environments = component;
  };
}
