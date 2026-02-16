{ inputs, ... }:
let
  module = {
    perSystem = { pkgs, ... }: with pkgs; let
      packages = [ nodePackages.bash-language-server shellcheck ];
    in {
      shells.default = { inherit packages; };
      shells.bash = { inherit packages; };
    };
  };

  component = {
    inherit module;
    dependencies = with inputs.parts; [
      components.nixology.parts.devShells
    ];
  };
in
{
  imports = [ module ];
  flake.components.nixology.environments.bash = component;
}
