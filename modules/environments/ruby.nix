local@{ ... }:
let
  implementation = {
    perSystem = { pkgs, ... }: with local.lib;
      {
        shellEnvs.ruby.packages = [
          pkgs.ruby
          pkgs.rubyPackages.rubocop
        ];

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

      dependencies = with local.inputs.flake.components; [
        nixology.extra.shellEnvs
        nixology.tools.treefmt
      ];

      meta = {
        description = "Provide Ruby development tooling and RuboCop formatting.";
        shortDescription = "Ruby development environment";
      };
    };
  };
}
