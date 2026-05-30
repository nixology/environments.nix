{ inputs, ... }:
let
  implementation = {
    perSystem =
      { lib, pkgs, ... }:
      {
        shellEnvs.node.packages = [
          pkgs.corepack
          pkgs.nodePackages.prettier
          pkgs.nodePackages.typescript
          pkgs.nodePackages.typescript-language-server
          pkgs.nodejs
        ];

        treefmt.programs.prettier.enable = lib.mkDefault true;
      };
  };
in
{
  imports = [
    implementation
  ];

  flake.components = {
    nixology.environments.node = {
      inherit implementation;

      dependencies = with inputs.flake.components; [
        nixology.extra.shellEnvs
        nixology.tools.treefmt
      ];

      meta = {
        description = "Provide Node.js development tooling and Prettier formatting.";
        shortDescription = "Node.js development environment";
      };
    };
  };
}
