{ inputs, ... }:
let
  module = {
    perSystem = { pkgs, ... }: {
      shellEnvironments = {
        ocaml = {
          packages = with pkgs; [
            dune_3
            ocaml
            ocamlPackages.ocaml-lsp
            ocamlPackages.ocamlformat
            ocamlPackages.utop
          ];
        };
      };
    };
  };
in
{
  imports = [ module ];

  flake.components = {
    nixology.environments.ocaml = {
      inherit module;

      dependencies = with inputs.flake.components; [ nixology.extra.shellEnvironments ];

      meta = {
        description = "Provide OCaml development tooling through a named shell environment.";
        shortDescription = "OCaml development environment";
      };
    };
  };
}
