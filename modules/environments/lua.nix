{ ... }@local:
let
  inherit (local.inputs.flake.components) nixology;

  inherit (local.lib) mkDefault;

  implementation = {
    perSystem = { pkgs, ... }: {
      shellEnvironments = {
        lua = {
          packages = with pkgs; [
            lua5_1
          ];
        };
      };

      treefmt.programs.stylua.enable = mkDefault true;
    };
  };
in
{
  imports = [
    implementation
  ];

  flake.components = {
    nixology.environments.lua = {
      inherit implementation;

      dependencies = [
        nixology.extra.shellEnvironments
        nixology.tools.treefmt
      ];

      meta = {
        description = "Provide Lua development tooling and StyLua formatting.";
        shortDescription = "Lua development environment";
      };
    };
  };
}
