{ inputs, ... }:
let
  flakeModule = let _file = __curPos.file; key = _file; in {
    inherit _file key;

    imports = [ inputs.flake.flakeModules.shells ];

    perSystem = { pkgs, ... }: with pkgs; {
      shells.default.packages = [ nil nix-output-monitor ];
    };
  };
in
{
  imports = [ inputs.flake.flakeModules.modules ];
  flake.modules.flake.nix = flakeModule;
}
