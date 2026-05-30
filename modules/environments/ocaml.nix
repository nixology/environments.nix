{ inputs, ... }:
let
  implementation = {
    perSystem =
      { pkgs, ... }:
      {
        shellEnvs.ocaml.packages = [
          pkgs.dune_3
          pkgs.ocaml
          pkgs.ocamlPackages.ocaml-lsp
          pkgs.ocamlPackages.ocamlformat
          pkgs.ocamlPackages.utop
        ];
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

      dependencies = with inputs.flake.components; [
        nixology.extra.shellEnvs
      ];

      meta = {
        description = "Provide OCaml development tooling through a named shell environment.";
        shortDescription = "OCaml development environment";
      };
    };
  };
}
