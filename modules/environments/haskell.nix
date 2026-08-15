{ inputs, ... }:
let
  module = {
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
  imports = [ module ];

  flake.components = {
    nixology.environments.haskell = {
      inherit module;

      dependencies = with inputs.flake.components; [ nixology.extra.shellEnvironments ];

      meta = {
        description = "Provide Haskell development tooling through a named shell environment.";
        shortDescription = "Haskell development environment";
      };
    };
  };
}
