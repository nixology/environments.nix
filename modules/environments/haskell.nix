{ ... }@local:
let
  inherit (local.inputs.flake.components) nixology;

  implementation = {
    perSystem = { pkgs, ... }: {
      shellEnvironments = {
        haskell = {
          packages = with pkgs; [
            cabal-install
            ghc
            haskell-language-server
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
    nixology.environments.haskell = {
      inherit implementation;

      dependencies = [
        nixology.extra.shellEnvironments
      ];

      meta = {
        description = "Provide Haskell development tooling through a named shell environment.";
        shortDescription = "Haskell development environment";
      };
    };
  };
}
