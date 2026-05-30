{ inputs, ... }:
let
  implementation = {
    perSystem =
      { pkgs, ... }:
      {
        shellEnvs.haskell.packages = [
          pkgs.cabal-install
          pkgs.ghc
          pkgs.haskell-language-server
        ];
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

      dependencies = with inputs.flake.components; [
        nixology.extra.shellEnvs
      ];

      meta = {
        description = "Provide Haskell development tooling through a named shell environment.";
        shortDescription = "Haskell development environment";
      };
    };
  };
}
