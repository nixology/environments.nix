local@{ ... }:
let
  implementation = {
    perSystem = { pkgs, ... }: with local.lib;
      {
        shellEnvs.bash.packages = [
          pkgs.nodePackages.bash-language-server
          pkgs.shellcheck
        ];

        treefmt.programs.shfmt.enable = mkDefault true;
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

      dependencies = with local.inputs.flake.components; [
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
