{ inputs, ... }:
let
  module = {
    perSystem = { pkgs, ... }: {
      shellEnvironments = {
        csharp = {
          packages = with pkgs; [
            dotnet-sdk
          ];
        };
      };
    };
  };
in
{
  imports = [ module ];

  flake.components = {
    nixology.environments.csharp = {
      inherit module;

      dependencies = with inputs.flake.components; [ nixology.extra.shellEnvironments ];

      meta = {
        description = "Provide C#/.NET development tooling through a named shell environment.";
        shortDescription = "C# development environment";
      };
    };
  };
}
