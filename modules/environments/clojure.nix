{ inputs, ... }:
let
  implementation = {
    perSystem =
      { pkgs, ... }:
      {
        shellEnvs.clojure.packages = [
          pkgs.clj-kondo
          pkgs.clojure
          pkgs.leiningen
        ];
      };
  };
in
{
  imports = [
    implementation
  ];

  flake.components = {
    nixology.environments.clojure = {
      inherit implementation;

      dependencies = with inputs.flake.components; [
        nixology.extra.shellEnvs
      ];

      meta = {
        description = "Provide Clojure development tooling through a named shell environment.";
        shortDescription = "Clojure development environment";
      };
    };
  };
}
