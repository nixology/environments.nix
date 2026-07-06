{ ... }@local:
let
  inherit (local.inputs.flake.components) nixology;

  implementation = {
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
  imports = [
    implementation
  ];

  flake.components = {
    nixology.environments.csharp = {
      inherit implementation;

      dependencies = [
        nixology.extra.shellEnvironments
      ];

      meta = {
        description = "Provide C#/.NET development tooling through a named shell environment.";
        shortDescription = "C# development environment";
      };
    };
  };
}
