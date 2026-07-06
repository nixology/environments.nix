{ ... }@local:
let
  inherit (local.inputs.flake.components) nixology;

  inherit (local.lib) mkDefault;

  implementation = {
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

      treefmt.programs.prettier.enable = mkDefault true;
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

      dependencies = [
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
