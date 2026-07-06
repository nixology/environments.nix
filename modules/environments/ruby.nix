{ ... }@local:
let
  inherit (local.inputs.flake.components) nixology;

  inherit (local.lib) mkDefault;

  implementation = {
    perSystem = { pkgs, ... }: {
      shellEnvironments = {
        ruby = {
          packages = with pkgs; [
            ruby
            rubyPackages.rubocop
          ];
        };
      };

      treefmt.programs.rubocop.enable = mkDefault true;
    };
  };
in
{
  imports = [
    implementation
  ];

  flake.components = {
    nixology.environments.ruby = {
      inherit implementation;

      dependencies = [
        nixology.extra.shellEnvironments
        nixology.tools.treefmt
      ];

      meta = {
        description = "Provide Ruby development tooling and RuboCop formatting.";
        shortDescription = "Ruby development environment";
      };
    };
  };
}
