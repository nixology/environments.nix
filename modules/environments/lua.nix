{ inputs, ... }:
let
  flakeModule = let _file = __curPos.file; key = _file; in {
    inherit _file key;

    imports = [ inputs.flake.flakeModules.shells ];

    perSystem = { pkgs, ... }: with pkgs; {
      shells.default.packages = [ lua5_1 ];
    };
  };
in
{
  imports = [ inputs.flake.flakeModules.modules ];
  flake.modules.flake.lua = flakeModule;
}
