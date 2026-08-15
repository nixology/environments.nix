{ inputs, lib, ... }:
let
  module = {
    perSystem = { pkgs, ... }: {
      shellEnvironments = {
        node = {
          packages = with pkgs; [
            corepack
            nodejs
            prettier
            typescript
            typescript-language-server
          ];
        };
      };

      treefmt.programs.prettier.enable = lib.mkDefault true;
    };
  };
in
{
  imports = [ module ];

  flake.components = {
    nixology.environments.node = {
      inherit module;

      dependencies = with inputs.flake.components; [
        nixology.extra.shellEnvironments
        nixology.tools.treefmt
      ];

      meta = {
        description = "Provide Node.js development tooling and Prettier formatting.";
        shortDescription = "Node.js development environment";
      };
    };
  };
}
