{ inputs, ... }:
let
  module = {
    perSystem = { pkgs, ... }: {
      shellEnvironments = {
        clojure = {
          packages = with pkgs; [
            clj-kondo
            clojure
            leiningen
          ];
        };
      };
    };
  };
in
{
  imports = [ module ];

  flake.components = {
    nixology.environments.clojure = {
      inherit module;

      dependencies = with inputs.flake.components; [ nixology.extra.shellEnvironments ];

      meta = {
        description = "Provide Clojure development tooling through a named shell environment.";
        shortDescription = "Clojure development environment";
      };
    };
  };
}
