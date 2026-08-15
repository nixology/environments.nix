{ inputs, lib, ... }:
let
  module = {
    perSystem = { pkgs, ... }: {
      shellEnvironments = {
        bash = {
          packages = with pkgs; [
            bash-language-server
            shellcheck
          ];
        };
      };

      treefmt.programs.shfmt.enable = lib.mkDefault true;
    };
  };
in
{
  imports = [ module ];

  flake.components = {
    nixology.environments.bash = {
      inherit module;

      dependencies = with inputs.flake.components; [
        nixology.extra.shellEnvironments
        nixology.tools.treefmt
      ];

      meta = {
        description = "Provide Bash development tooling and shfmt formatting.";
        shortDescription = "Bash development environment";
      };
    };
  };
}
