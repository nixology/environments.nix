{ inputs, ... }:
let
  module = {
    perSystem =
      { pkgs, ... }:
      {
        shellEnvs.csharp = {
          packages = with pkgs; [
            dotnet-sdk
          ];
        };
      };
  };

  component = {
    inherit module;
    dependencies = with inputs.flake.components; [
      nixology.extra.shellEnvs
    ];
  };
in
{
  imports = [ module ];
  flake.components = {
    nixology.environments.csharp = component;
  };
}
