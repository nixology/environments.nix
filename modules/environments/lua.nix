{ inputs, ... }:
let
  implementation = {
    perSystem =
      { lib, pkgs, ... }:
      {
        shellEnvs.lua.packages = [
          pkgs.lua5_1
        ];

        treefmt.programs.stylua.enable = lib.mkDefault true;
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

      dependencies = with inputs.flake.components; [
        nixology.extra.shellEnvs
        nixology.tools.treefmt
      ];

      meta = {
        description = "Provide Lua development tooling and StyLua formatting.";
        shortDescription = "Lua development environment";
      };
    };
  };
}
