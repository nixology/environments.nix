{ inputs, ... }:
let
  module = {
    perSystem =
      { pkgs, ... }:
      let
        shell = {
          packages = with pkgs; [
            nodePackages.bash-language-server
            shellcheck
          ];
        };
      in
      {
        shells.bash = shell;
      };
  };

  component = {
    inherit module;
    dependencies = with inputs.flake.components; [
      nixology.extra.shells
    ];
  };
in
{
  imports = [ module ];
  flake.components = {
    nixology.environments.bash = component;
  };
}
