local@{ ... }:
let
  inherit (local.lib)
    mkDefault
    ;

  implementation = {
    perSystem =
      { pkgs, ... }:
      {
        shellEnvs.lua.packages = [
          pkgs.lua5_1
        ];

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

      dependencies = with local.inputs.flake.components; [
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
