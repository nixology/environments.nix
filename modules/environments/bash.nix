{ ... }@local:
let
  inherit (local.inputs.flake.components) nixology;

  inherit (local.lib) mkDefault;

  implementation = {
    perSystem = { pkgs, ... }: {
      shellEnvironments = {
        bash = {
          packages = with pkgs; [
            bash-language-server
            shellcheck
          ];
        };
      };

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

      dependencies = [
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
