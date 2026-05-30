{ inputs, ... }:
let
  implementation = {
    perSystem =
      { lib, pkgs, ... }:
      {
        shellEnvs.bash.packages = [
          pkgs.nodePackages.bash-language-server
          pkgs.shellcheck
        ];

        treefmt.programs.shfmt.enable = lib.mkDefault true;
      };
  };
in
{
  imports = [
    implementation
  ];

  flake.components = {
    nixology.environments.bash = {
      inherit implementation;

      dependencies = with inputs.flake.components; [
        nixology.extra.shellEnvs
        nixology.tools.treefmt
      ];

      meta = {
        description = "Provide Bash development tooling and shfmt formatting.";
        shortDescription = "Bash development environment";
      };
    };
  };
}
