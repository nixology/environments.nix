{ ... }@local:
let
  inherit (local.inputs.flake.components) nixology;

  implementation = {
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
  imports = [
    implementation
  ];

  flake.components = {
    nixology.environments.clojure = {
      inherit implementation;

      dependencies = [
        nixology.extra.shellEnvironments
      ];

      meta = {
        description = "Provide Clojure development tooling through a named shell environment.";
        shortDescription = "Clojure development environment";
      };
    };
  };
}
