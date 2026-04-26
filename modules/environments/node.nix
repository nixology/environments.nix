{ inputs, ... }:
let
  module = {
    perSystem =
      { lib, pkgs, ... }:
      {
        shellEnvs.node = {
          packages = with pkgs; [
            corepack
            nodePackages.prettier
            nodePackages.typescript
            nodePackages.typescript-language-server
            nodejs
          ];
        };
        treefmt.programs = {
          prettier.enable = lib.mkDefault true;
        };
      };
  };

  component = {
    inherit module;
    dependencies = with inputs.flake.components; [
      nixology.extra.shellEnvs
      nixology.tools.treefmt
    ];
  };
in
{
  imports = [ module ];
  flake.components = {
    nixology.environments.node = component;
  };
}
