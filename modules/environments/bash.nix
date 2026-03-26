{ inputs, ... }:
let
  module = {
    perSystem =
      { lib, pkgs, ... }:
      {
        shellEnvs.bash = {
          packages = with pkgs; [
            nodePackages.bash-language-server
            shellcheck
          ];
        };
        treefmt.programs = {
          shfmt.enable = lib.mkDefault true;
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
    nixology.environments.bash = component;
  };
}
