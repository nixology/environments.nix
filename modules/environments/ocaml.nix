{ ... }@local:
let
  inherit (local.inputs.flake.components) nixology;

  implementation = {
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
  imports = [
    implementation
  ];

  flake.components = {
    nixology.environments.ocaml = {
      inherit implementation;

      dependencies = [
        nixology.extra.shellEnvironments
      ];

      meta = {
        description = "Provide OCaml development tooling through a named shell environment.";
        shortDescription = "OCaml development environment";
      };
    };
  };
}
