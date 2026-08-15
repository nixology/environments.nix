{ inputs, lib, ... }:
let
  module =
    { self, ... }:
    {
      perSystem =
        { pkgs, ... }:
        let
          flakeRoot = builtins.path { path = self; };

          recipe = pkgs.writeShellScriptBin "recipe" ''
            exec ${lib.getExe pkgs.just} \
              --working-directory . \
              --justfile ${flakeRoot}/justfile \
              "$(basename "$0")" "$@"
          '';

          justAliases =
            pkgs.runCommand "just-aliases"
              {
                src = flakeRoot;
                nativeBuildInputs = [
                  pkgs.coreutils
                  pkgs.gawk
                  pkgs.just
                ];
              }
              ''
                mkdir -p "$out/bin"
                touch "$out/bin/.placeholder"

                if [ -f "$src/justfile" ]; then
                  just --summary --justfile "$src/justfile" \
                    | tr ' ' '\n' \
                    | awk -F: '{ print $1 }' \
                    | sort -u \
                    | while read -r name; do
                      ln -s ${lib.getExe recipe} "$out/bin/$name"
                    done
                else
                  echo "No justfile found in $src"
                fi
              '';
        in
        {
          shellEnvironments = {
            just = {
              packages = with pkgs; [
                just
                justAliases
              ];
            };
          };

          treefmt.programs.just.enable = lib.mkDefault true;
        };
    };
in
{
  imports = [ module ];

  flake.components = {
    nixology.environments.just = {
      inherit module;

      dependencies = with inputs.flake.components; [
        nixology.extra.shellEnvironments
        nixology.tools.treefmt
      ];

      meta = {
        description = "Provide Just command runner tooling, recipe aliases, and justfile formatting.";
        shortDescription = "Just development environment";
      };
    };
  };
}
