{ inputs, ... }:
let
  implementation = {
    perSystem =
      { pkgs, ... }:
      {
        shellEnvs.csharp.packages = [
          pkgs.dotnet-sdk
        ];
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

      dependencies = with inputs.flake.components; [
        nixology.extra.shellEnvs
      ];

      meta = {
        description = "Provide C#/.NET development tooling through a named shell environment.";
        shortDescription = "C# development environment";
      };
    };
  };
}
